# 📊 Customer Churn Analysis Using Random Forest in R

## 📌 Abstract

Customer churn is a critical issue in the telecommunications industry as it directly affects revenue and long-term growth. This project analyzes customer churn using a dataset containing 2666 observations and 20 variables representing customer demographics, usage patterns, and service details.

The Random Forest algorithm was applied to identify the most influential factors contributing to churn. The model achieved high predictive performance with:

- ✅ Accuracy: 94.49%
- ✅ AUC Score: 0.9194
- ✅ OOB Accuracy: 95.77%

The study highlights International Plan and Customer Service Calls as the most critical drivers of churn, providing actionable insights for retention strategies.

---

# 📖 Table of Contents

1. Introduction  
2. Objective and Data Description  
3. Literature Review  
4. Methodology  
   - Exploratory Data Analysis (EDA)  
   - Model Building using Random Forest  
   - Variable Selection (VSURF)  
   - Model Adequacy Checking  
5. Data Analysis  
6. Model Evaluation  
7. Conclusion  

---

# 1️⃣ Introduction

Customer churn refers to customers discontinuing services from a company. In telecom industries, retaining customers is significantly more cost-effective than acquiring new ones. 

This project focuses on identifying and understanding the factors influencing churn using statistical and machine learning techniques in R.

---

# 2️⃣ Objective

- Identify key factors influencing telecom customer churn.
- Analyze how these factors impact churn behavior.
- Build a predictive model using Random Forest.
- Evaluate model performance using classification metrics.

---

# 3️⃣ Dataset Description

- 📦 Observations: 2666 customers
- 📊 Variables: 20 features
- 🎯 Target Variable: `Churn` (TRUE/FALSE)

### Key Features:
- Account Length
- International Plan
- Voicemail Plan
- Day / Evening / Night usage & charges
- International usage & charges
- Customer Service Calls

After cleaning:
- Removed: `State`, `Area.code`
- Final dataset: 2666 observations × 18 variables

---

# 4️⃣ Methodology

## 🔹 Data Cleaning
- Checked for missing values (none found)
- Removed irrelevant columns
- Checked duplicates (none found)
- Renamed columns for clarity
- Converted categorical variables to factors

## 🔹 Exploratory Data Analysis (EDA)

### Univariate Analysis
- Churn distribution (Bar plot)
- International & Voicemail plan distribution (Pie & Bar charts)
- Histograms for numeric variables

### Multivariate Analysis
- Churn vs Plans
- Usage variables vs Churn
- Correlation matrix for numeric features

Strong correlations were observed between:
- Day Minutes & Day Charge
- Evening Minutes & Evening Charge
- Night Minutes & Night Charge
- International Minutes & International Charge

---

# 5️⃣ Model Building

## 🔹 Train-Test Split
- 70% Training
- 30% Testing

## 🔹 Initial Random Forest Model
- Trees: 500
- OOB Error: 4.45%
- OOB Accuracy: 95.55%
- Test Accuracy: 94.12%

---

# 6️⃣ Variable Selection (VSURF)

Selected 13 most important predictors:

- Day min
- Day charge
- Intl plan
- CS calls
- Eve min
- Eve charge
- Night charge
- Night min
- Intl calls
- Intl min
- Intl charge
- VM msgs
- VM plan

This reduced model complexity while maintaining high performance.

---

# 7️⃣ Cross-Vali
