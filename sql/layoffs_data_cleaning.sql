-- DATA CLEANING PROJECT: Layoffs 2022

CREATE TABLE world_layoffs.layoffs_staging LIKE world_layoffs.layoffs;
INSERT INTO world_layoffs.layoffs_staging SELECT * FROM world_layoffs.layoffs;

-- STEP 2: Remove Duplicates
CREATE TABLE world_layoffs.layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT,
    row_num INT
);

INSERT INTO world_layoffs.layoffs_staging2
SELECT *, ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off,
    percentage_laid_off, `date`, stage, country, funds_raised_millions
) AS row_num
FROM world_layoffs.layoffs_staging;

DELETE FROM world_layoffs.layoffs_staging2 
WHERE
    row_num >= 2;

-- STEP 3: Standardize Industry Names
UPDATE world_layoffs.layoffs_staging2 
SET 
    industry = NULL
WHERE
    industry = '';

UPDATE world_layoffs.layoffs_staging2 t1
        JOIN
       world_layoffs.layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;

UPDATE world_layoffs.layoffs_staging2 
SET 
    industry = 'Crypto'
WHERE
    industry IN ('Crypto Currency' , 'CryptoCurrency');

-- STEP 4: Clean Country Column
UPDATE world_layoffs.layoffs_staging2 
SET 
    country = TRIM(TRAILING '.' FROM country);

-- STEP 5: Fix Date Format
UPDATE world_layoffs.layoffs_staging2 
SET 
    `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE world_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STEP 6: Remove Unusable Rows
DELETE FROM world_layoffs.layoffs_staging2 
WHERE
    total_laid_off IS NULL
    AND percentage_laid_off IS NULL;

-- STEP 7: Final Cleanup
ALTER TABLE world_layoffs.layoffs_staging2
DROP COLUMN row_num;

-- ✅ Cleaned table is now ready for EDA and analysis


