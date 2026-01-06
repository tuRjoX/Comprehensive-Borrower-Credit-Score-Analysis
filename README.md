# Comprehensive Borrower Credit Score Analysis

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge)
![Data Science](https://img.shields.io/badge/Data%20Science-Project-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

## 📋 Table of Contents

- [Project Description](#project-description)
- [Features](#features)
- [How to Install and Run the Project](#how-to-install-and-run-the-project)
- [How to Use the Project](#how-to-use-the-project)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Credits](#credits)
- [License](#license)

## 📖 Project Description

This project focuses on **credit score analysis** for borrowers using comprehensive data analysis and machine learning techniques. The system analyzes various financial and demographic factors to predict borrower creditworthiness, which is crucial for financial institutions to make informed lending decisions.

The project implements **three complete analytical approaches**:

1. **Classification Analysis** (`H-G01-final-classification.R`)

   - Decision Tree classification models
   - Credit score category prediction
   - Model performance evaluation and comparison

2. **Clustering Analysis** (`H-G01-final-clustering.R`)

   - K-means and hierarchical clustering
   - Customer segmentation based on credit behavior
   - Optimal cluster determination

3. **Regression Analysis** (`H-G01-final-regression .R`)
   - Linear and non-linear regression models
   - Credit score prediction as continuous variable
   - Feature importance and relationship analysis

**Core Features**:

- **Data preprocessing and cleaning** of borrower information
- **Exploratory Data Analysis (EDA)** with comprehensive visualizations
- **Feature engineering** and correlation analysis
- **Multiple machine learning approaches** (classification, clustering, regression)
- **Model evaluation** using cross-validation and performance metrics
- **Statistical analysis** to identify key factors affecting credit scores

This tool can help financial institutions automate credit assessment, reduce risk and improve decision-making processes.

## ✨ Features

- 📊 **Comprehensive Data Analysis**: Statistical analysis of borrower data across multiple analytical frameworks
- 🔍 **Feature Correlation**: Identify relationships between variables
- 🤖 **Multiple ML Approaches**:
  - Classification models (Decision Trees)
  - Clustering algorithms (K-means, PCA)
  - Regression models (Linear Regrssion)
- 📈 **Visualization Suite**: Interactive plots and charts using ggplot2, factoextra
- ⚡ **Parallel Processing**: Efficient computation using future and future.apply
- 🎯 **Model Evaluation**: Cross-validation and comprehensive performance metrics
- 📉 **Information Theory Metrics**: Mutual information and entropy analysis
- 🎨 **Clustering Visualization**: Dendrograms, elbow plots, and silhouette analysis
- 🌳 **Decision Tree Visualization**: Interactive tree plots with rpart.plot

## 🚀 How to Install and Run the Project

### Prerequisites

- **R** (version 4.0 or higher)
- **RStudio** (recommended for easier execution)

### Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/tuRjoX/Borrower-Credit-Score-Classification-Using-Datasets-Analysis.git
   cd Borrower-Credit-Score-Classification-Using-Datasets-Analysis
   ```

2. **Install required R packages**

   Open R or RStudio and run any of the scripts. The required packages will be automatically installed:

   **Common packages** (all scripts):

   - dplyr, ggplot2, reshape2, GGally, e1071, readr
   - corrplot, caret, infotheo, rpart, rpart.plot

   **Additional packages**:

   - `H-G01-final-clustering.R`: cluster, factoextra

3. **Verify data file**

   Ensure `bank_modified.csv` is present in the project directory, or the script will download it automatically from the configured URL.

### Running the Project

**Choose the appropriate script based on your analysis goal:**

**1. Classification Analysis** (`H-G01-final-classification.R`)

```r
source("H-G01-final-classification.R")
```

Use this for predicting credit score categories using Decision Trees.

**2. Clustering Analysis** (`H-G01-final-clustering.R`)

```r
source("H-G01-final-clustering.R")
```

Use this for customer segmentation and identifying borrower groups.

**3. Regression Analysis** (`H-G01-final-regression .R`)

```r
source("H-G01-final-regression .R")
```

Use this for predicting credit scores as continuous values.

**4. Mid-Project Analysis** (`H-G01-mid-project.R`)

```r
source("H-G01-mid-project.R")
```

Use this for the initial exploratory analysis.

**Using RStudio:**

1. Open any script in RStudio
2. Click "Source" or press `Ctrl+Shift+S` to run the entire script
3. Or run sections interactively by selecting code and pressing `Ctrl+Enter`

**Using Command Line:**

```bash
Rscript H-G01-final-classification.R
# or
Rscript H-G01-final-clustering.R
# or
Rscript "H-G01-final-regression .R"
```

## 💡 How to Use the Project

### Basic Usage

1. **Select your analysis type**: Choose from Classification, Clustering, or Regression based on your objective

2. **Load the script**: Open the corresponding R file in your R environment

3. **Data Understanding**: Each script automatically:

   - Loads the dataset from Google Drive
   - Displays summary statistics
   - Shows data structure and types
   - Identifies missing values

4. **Exploratory Data Analysis**:

   - Generates visualizations automatically
   - Analyzes correlations between features
   - Identifies patterns and outliers

5. **Model Training & Analysis**:

   **Classification Script:**

   - Trains SVM and Decision Tree models
   - Evaluates using confusion matrices and accuracy metrics
   - Compares model performance

   **Clustering Script:**

   - Performs K-means and hierarchical clustering
   - Determines optimal number of clusters
   - Visualizes clusters and dendrograms

   **Regression Script:**

   - Builds linear and non-linear regression models
   - Evaluates using RMSE, R-squared, and MAE
   - Analyzes residuals and model fit

6. **Results Interpretation**:
   - Review model performance metrics
   - Analyze feature importance
   - Examine visualizations and diagnostic plots

### Example Output

The scripts generate:

- Statistical summaries of borrower data
- Correlation matrices and heatmaps
- Feature importance plots
- Model performance metrics
- **Classification**: Confusion matrices, ROC curves, accuracy scores
- **Clustering**: Dendrograms, elbow plots, silhouette analysis, cluster profiles
- **Regression**: Scatter plots, residual plots, prediction accuracy metrics

## 📁 Project Structure

```
Borrower-Credit-Score-Classification-Using-Datasets-Analysis/
│
├── H-G01-mid-project.R              # Initial exploratory analysis and models
├── H-G01-final-classification.R     # Classification models (SVM, Decision Trees)
├── H-G01-final-clustering.R         # Clustering analysis (K-means, Hierarchical)
├── H-G01-final-regression .R        # Regression models (Linear, Non-linear)
├── bank_modified.csv                # Dataset (borrower information)
└── LICENSE                          # Apache 2.0 License
```

## 🛠️ Technologies Used

- **R Programming Language**: Core analysis and modeling
- **dplyr**: Data manipulation and transformation
- **ggplot2**: Data visualization
- **caret**: Machine learning framework
- **e1071**: SVM and other ML algorithms
- **corrplot**: Correlation visualization
- **GGally**: Advanced plotting functions
- **infotheo**: Information theory metrics
- **rpart/rpart.plot**: Decision tree modeling and visualization
- **cluster**: Clustering algorithms
- **factoextra**: Clustering visualization and analysis
- **future/future.apply**: Parallel processing (mid-project)

## 👥 Credits

### Developed By

- [**Turjo Das Dip**](https://github.com/tuRjoX)
- [**Nusrat Faraezi Ivy**](https://github.com/ivyfaraezi)
- [**Saima Ahmed Tanjila**](https://github.com/Saima2309)

## 📄 License

This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.

```
Copyright 2025 tuRjoX

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

<div align="center">
  <p>⭐ Star this repository if you found it helpful!</p>
</div>
