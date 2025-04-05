# End-to-End EDA with MySQL: From Raw Layoff Data to Insights

This project walks through a complete data analysis pipeline using SQL — from cleaning raw layoff records to performing exploratory data analysis (EDA) directly in MySQL.

The dataset includes records of company layoffs, dates, employee counts, and more. Using SQL, we cleaned the data, handled nulls/duplicates, and uncovered trends across companies, industries, and time periods.

---

## 📊 Dataset
- **Source**: [Layoffs Dataset on Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- Contains data on tech company layoffs from 2020–2023, including:
  - Company name
  - Industry
  - Location
  - Number of layoffs
  - Funding stage
  - Percentage laid off
  - Date of layoffs

---

## 🧹 Data Cleaning Steps

Here’s what I did in the `layoffs_data_cleaning.sql` file:

1. **Removed duplicates**
   - Used `ROW_NUMBER()` to find and delete true duplicates.

2. **Standardized values**
   - Changed "CryptoCurrency", "Crypto Currency" → "Crypto"
   - Fixed "United States." → "United States"
   - Fixed `industry` and `country` inconsistencies.

3. **Handled missing data**
   - Filled missing `industry` values based on matching company names.
   - Left some nulls for better EDA later (like in layoffs count).

4. **Fixed date format**
   - Converted the date column from text to `DATE` type using `STR_TO_DATE()`.

5. **Dropped irrelevant rows**
   - Removed rows with no layoff info (both `total_laid_off` and `percentage_laid_off` were null).

---

## 📈 Exploratory Data Analysis (EDA)

After cleaning the data, I conducted exploratory data analysis (EDA) directly in MySQL using the `layoffs_exploratory_analysis.sql` file. The EDA focused on uncovering patterns and trends in the dataset, such as:

1. **Basic Statistical Analysis:**
   - Calculated basic summary statistics for layoff counts and percentage laid off across different companies and industries.

2. **Trend Analysis:**
   - Analyzed layoffs over time (from 2020 to 2023) to uncover trends and possible seasonal effects.

3. **Industry-Specific Analysis:**
   - Aggregated layoffs by industry to see which sectors were most affected by layoffs.
   - Analyzed industries that had the largest number of layoffs in specific periods.

4. **Geographical Insights:**
   - Investigated layoffs by location (country, city) to uncover trends in different regions.

5. **Layoffs vs. Funding Stage:**
   - Analyzed the correlation between layoffs and the funding stage of companies to uncover patterns in how companies at different stages of funding handled layoffs.

---
   - ## 💻 Tools Used
- **SQL Dialect**: MySQL
- **Platform**: MySQL Workbench
- **Dataset**: Kaggle Layoffs 2022

### Repository Structure:
end-to-end-mysql-eda/
├── data/
│   ├── layoffs_raw_data.csv                   # Original dataset before cleaning
│   └── layoffs_cleaned_data.csv               # Cleaned dataset after SQL operations
├── sql/
│   ├── layoffs_data_cleaning.sql              # SQL script for data cleaning
│   └── layoffs_exploratory_analysis.sql       # SQL script for EDA
├── README.md                                  # Project documentation and overview


