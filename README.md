# layoffs-data-cleaning
SQL project to clean and prepare 2022 layoffs dataset for analysis using MySQL.
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
  - ## 🧹 Data Cleaning Steps

Here’s what I did in the `layoffs_data_cleaning.sql` file:

1. **Removed duplicates**
   - Used `ROW_NUMBER()` to find and delete true duplicates.

2. **Standardized values**
   - Changed "CryptoCurrency", "Crypto Currency" → "Crypto"
   - Fixed "United States." → "United States"
   - Fixed `industry` and `country` inconsistencies

3. **Handled missing data**
   - Filled missing `industry` values based on matching company names
   - Left some nulls for better EDA later (like in layoffs count)

4. **Fixed date format**
   - Converted date column from text to `DATE` type using `STR_TO_DATE()`

5. **Dropped irrelevant rows**
   - Removed rows with no layoff info (both `total_laid_off` and `percentage_laid_off` were null)
   - 
   - ## 💻 Tools Used
- **SQL Dialect**: MySQL
- **Platform**: MySQL Workbench
- **Dataset**: Kaggle Layoffs 2022

- ## 📁 Project Structure
