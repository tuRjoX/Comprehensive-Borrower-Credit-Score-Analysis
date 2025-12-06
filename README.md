# Borrower Credit Score Classification Using Datasets Analysis

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

This project focuses on **credit score classification** for borrowers using comprehensive data analysis and machine learning techniques. The system analyzes various financial and demographic factors to predict borrower creditworthiness, which is crucial for financial institutions to make informed lending decisions.

The project implements:

- **Data preprocessing and cleaning** of borrower information
- **Exploratory Data Analysis (EDA)** with visualizations
- **Feature engineering** and correlation analysis
- **Machine learning models** including SVM
- **Model evaluation** using cross-validation and performance metrics
- **Statistical analysis** to identify key factors affecting credit scores

This tool can help financial institutions automate credit assessment, reduce risk and improve decision-making processes.

## ✨ Features

- 📊 **Comprehensive Data Analysis**: Statistical analysis of borrower data
- 🔍 **Feature Correlation**: Identify relationships between variables
- 🤖 **Multiple ML Models**: SVM and other classification algorithms
- 📈 **Visualization Suite**: Interactive plots and charts using ggplot2
- ⚡ **Parallel Processing**: Efficient computation using future and future.apply
- 🎯 **Model Evaluation**: Cross-validation and performance metrics
- 📉 **Information Theory Metrics**: Mutual information and entropy analysis

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

   Open R or RStudio and run the script. The required packages will be automatically installed:

   - dplyr
   - ggplot2
   - reshape2
   - GGally
   - e1071
   - readr
   - corrplot
   - caret
   - infotheo
   - future
   - future.apply

3. **Verify data file**

   Ensure `bank_modified.csv` is present in the project directory, or the script will download it automatically from the configured URL.

### Running the Project

**Option 1: Using RStudio**

1. Open `H-G01-mid-project.R` in RStudio
2. Click "Source" or press `Ctrl+Shift+S` to run the entire script
3. Or run sections interactively by selecting code and pressing `Ctrl+Enter`

**Option 2: Using R Console**

```r
source("H-G01-mid-project.R")
```

**Option 3: Using Command Line**

```bash
Rscript H-G01-mid-project.R
```

## 💡 How to Use the Project

### Basic Usage

1. **Load the script**: Open `H-G01-mid-project.R` in your R environment

2. **Data Understanding**: The script automatically loads and explores the dataset

   - View summary statistics
   - Check data structure and types
   - Identify missing values

3. **Exploratory Data Analysis**:

   - Run the EDA section to generate visualizations
   - Analyze correlations between features
   - Identify patterns and outliers

4. **Model Training**:

   - The script trains multiple classification models
   - Models are evaluated using cross-validation
   - Performance metrics are displayed

5. **Results Interpretation**:
   - Review model accuracy and performance metrics
   - Analyze feature importance
   - Examine confusion matrices

### Example Output

The script generates:

- Statistical summaries of borrower data
- Correlation matrices and heatmaps
- Feature importance plots
- Model performance metrics
- Classification results

## 📁 Project Structure

```
Borrower-Credit-Score-Classification-Using-Datasets-Analysis/
│
├── H-G01-mid-project.R          # Main R script with analysis and models
├── bank_modified.csv            # Dataset (borrower information)
├── H-G01-mid-report.pdf/.docx   # Project documentation
└── LICENSE                      # Apache 2.0 License
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
- **future/future.apply**: Parallel processing

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
