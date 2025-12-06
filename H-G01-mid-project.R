# ============================================================
# Required Packages
# ============================================================
packages <- c("dplyr", "ggplot2", "reshape2", "GGally", "e1071", "readr",
              "corrplot", "caret", "infotheo", "future", "future.apply")

installed <- rownames(installed.packages())

for (p in packages) {
  if (!(p %in% installed)) install.packages(p)
}

library(dplyr)
library(ggplot2)
library(reshape2)
library(GGally)
library(e1071)
library(readr)
library(corrplot)
library(randomForest)
library(future)
library(future.apply)
library(caret)
library(infotheo)

# ============================================================
# A. DATA UNDERSTANDING
# ============================================================

url <- "https://drive.google.com/uc?export=download&id=153djv5IlB2WeDoeMLYT9vujlPUyGuf7S" 
data <- read_csv(url) 
head(data)

#Show shape (rows × columns)
dim(data)

#Display data types of each column
str(data)

#Generate summary statistics
summary(data)

#Identify numeric features
numeric_features <- names(data)[sapply(data, is.numeric)]
numeric_features

#Identify categorical features
categorical_features <- names(data)[sapply(data, is.character)]
categorical_features

# =======================
# B. Data Pre-processing
# =======================

# ----- Detect missing values before cleaning -----
cat("Missing Values Before Cleaning:\n")
print(colSums(is.na(data)))

# Separate numeric and categorical columns
numeric_cols <- names(data)[sapply(data, is.numeric)]
categorical_cols <- names(data)[sapply(data, is.character)]

data_clean <- data  

# ----- Impute numeric missing values with MEDIAN -----
for (col in numeric_cols) {
  med_val <- median(data_clean[[col]], na.rm = TRUE)
  data_clean[[col]][is.na(data_clean[[col]])] <- med_val
}

# ----- Mode function for categorical imputation -----
get_mode <- function(x) {
  ux <- unique(x[!is.na(x)])
  ux[which.max(tabulate(match(x, ux)))]
}

# ----- Impute categorical missing values with MODE -----
for (col in categorical_cols) {
  mode_val <- get_mode(data_clean[[col]])
  data_clean[[col]][is.na(data_clean[[col]])] <- mode_val
}

# ----- Show missing values after cleaning -----
cat("\nMissing Values After Cleaning:\n")
print(colSums(is.na(data_clean)))

# ======================================================
# HANDLING OUTLIERS
# ======================================================

numeric_cols <- names(data_clean)[sapply(data_clean, is.numeric)]

# Identify outliers using IQR method
cat("\nIdentifying Outliers using IQR Method...\n")
for (col in numeric_cols) {
  Q1 <- quantile(data_clean[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data_clean[[col]], 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  
  outliers <- sum(data_clean[[col]] < lower | data_clean[[col]] > upper, na.rm = TRUE)
  cat(col, "- Outliers Found:", outliers, "\n")
}

  
# Boxplot Visualization (Before Treatment)
  print(
    ggplot(data_clean, aes_string(y = col)) +
      geom_boxplot(fill = "pink") +
      ggtitle(paste("Boxplot of", col, "(Before Outlier Handling)")) +
      theme(plot.title = element_text(hjust = 0.5))
  )


# CAP OUTLIERS (Winsorization)
for (col in numeric_cols) {
  Q1 <- quantile(data_clean[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data_clean[[col]], 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  
  # Cap (Winsorize)
  data_clean[[col]][data_clean[[col]] < lower] <- lower
  data_clean[[col]][data_clean[[col]] > upper] <- upper
}

cat("\nOutliers have been capped using the Winsorization method.\n")

# Boxplots AFTER outlier treatment
for (col in numeric_cols) {
  print(
    ggplot(data_clean, aes_string(y = col)) +
      geom_boxplot(fill = "lightgreen") +
      ggtitle(paste("Boxplot of", col, "(After Outlier Handling)")) +
      theme(plot.title = element_text(hjust = 0.5))
  )
}

# ======================================================
# DATA CONVERSION 
# ======================================================

# Identify categorical features
categorical_features <- names(data_clean)[sapply(data_clean, is.character)]
categorical_features

# Label Encoding for ALL categorical variables
label_encode <- function(x) {
  as.numeric(factor(x, exclude = NULL))
}
for (col in categorical_features) {
  data_clean[[col]] <- label_encode(data_clean[[col]])
}
# Confirm all features are numeric now
str(data_clean)

# ======================================================
# 4. DATA TRANSFORMATION
# ======================================================

# Identify numeric columns
numeric_cols <- names(data_clean)[sapply(data_clean, is.numeric)]
numeric_cols <- numeric_cols[sapply(data_clean[numeric_cols], function(x) sd(x, na.rm = TRUE) != 0)]

# Z-score function
zscore <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}

# ------------------------------------------------------
# 1. STANDARDIZE ALL NUMERIC FEATURES (Z-score)
# ------------------------------------------------------

data_transformed <- data_clean
data_transformed[numeric_cols] <- lapply(data_clean[numeric_cols], zscore)

# Fix negative values after Z-score (needed for log transform)
duration_std <- data_transformed$duration

# Apply transformation depending on skewness
duration_skew <- skewness(duration_std)

cat("Original Duration Skewness:", duration_skew, "\n")

# If right-skewed → use log transform
if (duration_skew > 1) {
  # Shift values to make them positive
  duration_shifted <- duration_std - min(duration_std) + 1
  data_transformed$duration <- log(duration_shifted)
  cat("Applied LOG transformation to duration\n")
  
  # If moderate skew → use sqrt
} else if (duration_skew > 0.5) {
  duration_shifted <- duration_std - min(duration_std) + 1
  data_transformed$duration <- sqrt(duration_shifted)
  cat("Applied SQRT transformation to duration\n")
  
  # If symmetrical → keep as Z-score
} else {
  cat("Duration distribution is already symmetric. No extra transformation applied.\n")
}

# Update cleaned dataset
data_clean <- data_transformed
str(data_clean)


# -------------------------------
# FEATURE SELECTION PROCESS
# -------------------------------

# Separate numeric and categorical columns
numeric_cols <- names(data_clean)[sapply(data_clean, is.numeric)]
categorical_cols <- names(data_clean)[sapply(data_clean, is.character)]


# 1. CORRELATION ANALYSIS(Remove highly correlated features (above 0.85))
numeric_data <- data_clean[numeric_cols]
corr_matrix <- cor(numeric_data)

high_corr <- findCorrelation(corr_matrix, cutoff = 0.85)
cat("Highly Correlated Features to Remove:\n")
print(colnames(numeric_data)[high_corr])

# Data after removing high correlation
data_corr_removed <- data_clean[, !names(data_clean) %in% colnames(numeric_data)[high_corr]]


# 2. VARIANCE THRESHOLDING(Remove low-variance (near-zero variance) features)
nzv <- nearZeroVar(data_corr_removed)
cat("\nLow Variance Features to Remove:\n")
print(names(data_corr_removed)[nzv])

data_nzv_removed <- data_corr_removed[, -nzv]


# 3. MUTUAL INFORMATION (MI)(Determine importance of features relative to target)
data_MI <- data_nzv_removed
data_MI[categorical_cols] <- lapply(data_MI[categorical_cols], as.factor)

target_col <- "y" 

# Calculate MI for each feature
MI_scores <- sapply(setdiff(names(data_MI), target_col), function(col) {
  mutinformation(discretize(data_MI[[col]]), discretize(data_MI[[target_col]]))
})

cat("\nMutual Information Scores:\n")
print(MI_scores)


# 4. FINAL SELECTED FEATURES
selected_features <- names(data_nzv_removed)

cat("\nFINAL SELECTED FEATURES:\n")
print(selected_features)

# ===================================
# C. DATA EXPLORATION & VISUALIZATION 
# ===================================

# -----------------------------
# Univariate Analysis
# -----------------------------

# Histograms for Numeric Variables
histogram_plots <- list(
  ggplot(data_clean, aes(age)) +
    geom_histogram(binwidth = 2, fill="steelblue", color="black") +
    ggtitle("Distribution of Age") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(campaign)) +
    geom_histogram(binwidth = 5, fill="orange", color="black") +
    ggtitle("Distribution of Campaign") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(day)) +
    geom_histogram(binwidth = 5, fill="lightgreen", color="black") +
    ggtitle("Distribution of Days") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(balance)) +
    geom_histogram(binwidth = 1000, fill="purple", color="black") +
    ggtitle("Distribution of Balance") +
    theme(plot.title = element_text(hjust = 0.5))
)
histogram_plots

# Boxplots for Numeric Variables
plots_boxplot <- list(
  ggplot(data_clean, aes(y = age)) +
    geom_boxplot(fill = "tomato") +
    ggtitle("Boxplot of Age") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(y = campaign)) +
    geom_boxplot(fill = "green") +
    ggtitle("Boxplot of Campaign") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(y = day)) +
    geom_boxplot(fill = "yellow") +
    ggtitle("Boxplot of Days") +
    theme(plot.title = element_text(hjust = 0.5))
)
plots_boxplot

# Bar Plots for Categorical Variables
plots_barchart <- list(
  ggplot(data_clean, aes(job)) +
    geom_bar(fill="purple") +
    ggtitle("Frequency of Job Types") +
    theme(axis.text.x = element_text(angle = 90),
          plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(marital)) +
    geom_bar(fill="cyan") +
    ggtitle("Frequency of Marital Status") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(education)) +
    geom_bar(fill="magenta") +
    ggtitle("Frequency of Education Levels") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(default)) +
    geom_bar(fill="lightblue") +
    ggtitle("Frequency of Default Status") +
    theme(plot.title = element_text(hjust = 0.5))
)
plots_barchart

# Frequency of All Categorical Variables
for (col in categorical_features) {
  cat("\n-----", col, "-----\n")
  print(table(data_clean[[col]]))
  
  print(
    ggplot(data_clean, aes_string(x = col)) +
      geom_bar(fill = "skyblue") +
      ggtitle(paste("Frequency of",tools::toTitleCase(col))) +
      theme(axis.text.x = element_text(angle = 90, hjust = 0.5),
            plot.title = element_text(hjust = 0.5))
  )
}

# -----------------------------
# Bivariate Analysis
# -----------------------------

# Correlation Matrix (Heat Map)
# Select only numeric columns
numeric_cols <- data_clean[, sapply(data_clean, is.numeric), drop = FALSE]

# Remove columns where ALL values are NA or the column has no variance
numeric_cols <- numeric_cols[, sapply(numeric_cols, function(x) {
  x <- x[!is.na(x)]              
  if (length(x) <= 1) return(FALSE)  
  return(sd(x) != 0)             
}), drop = FALSE]

  corr_matrix <- cor(numeric_cols, use = "pairwise.complete.obs")
  corr_melt <- melt(corr_matrix)
  ggplot(corr_melt, aes(Var1, Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
    ggtitle("Correlation Heatmap of Numeric Variables") +
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1),
      axis.text.y = element_text(angle = 0),
      axis.title = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )

# Scatterplot Matrix colored by Duration
pairs(data_clean[, 1:4], main = "Scatterplot Matrix of Iris Data", col = iris$Species)
  
# Boxplots for Bivariate Analysis
plots_boxplot2 <- list(
  ggplot(data_clean, aes(job, balance)) +
    geom_boxplot(fill="lightgreen") +
    ggtitle("Balance by Job Type") +
    theme(axis.text.x = element_text(angle=90),
          plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(marital, age)) +
    geom_boxplot(fill="lightcoral") +
    ggtitle("Age by Marital Status") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(education, campaign)) +
    geom_boxplot(fill="lightblue") +
    ggtitle("Campaign by Education Level") +
    theme(plot.title = element_text(hjust = 0.5)),
  
  ggplot(data_clean, aes(default, day)) +
    geom_boxplot(fill="lightyellow") +
    ggtitle("Days by Default Status") +
    theme(plot.title = element_text(hjust = 0.5))
)
plots_boxplot2


# -----------------------------
# Multivariate Analysis
# -----------------------------

# Skewness
for (col in numeric_features) {
  cat(col, "- Skewness:", skewness(data_clean[[col]]), "\n")
}

# Outlier Detection (IQR Method)
for (col in numeric_features) {
  Q1 <- quantile(data_clean[[col]], 0.25)
  Q3 <- quantile(data_clean[[col]], 0.75)
  IQR_val <- Q3 - Q1
  
  outliers <- data_clean[[col]] < (Q1 - 1.5*IQR_val) | 
    data_clean[[col]] > (Q3 + 1.5*IQR_val)
  
  cat(col, "- Number of Outliers:", sum(outliers), "\n")
}

