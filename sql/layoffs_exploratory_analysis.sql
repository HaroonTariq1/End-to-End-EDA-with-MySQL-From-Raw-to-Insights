-- Exploratory Data Analysis

-- Select all records
SELECT *
FROM layoffs_staging2;

-- Check maximum values
SELECT 
    MAX(total_laid_off), 
    MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Filter data by percentage laid off = 1 and order by total laid off descending
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Group by company and order by total laid off descending
SELECT 
    company, 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Find the minimum and maximum date
SELECT 
    MIN(`date`), 
    MAX(`date`)
FROM layoffs_staging2;

-- Group by country and order by total laid off descending
SELECT 
    country, 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Select all records again
SELECT *
FROM layoffs_staging2;

-- Separate sum of laid off by date
SELECT 
    `date`, 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- Split the year and sum of laid off
SELECT 
    YEAR(`date`), 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Group by stage and order by total laid off descending
SELECT 
    stage, 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Rolling total layoff based on month
SELECT 
    SUBSTRING(`date`, 1, 7) AS `MONTH`, 
    SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Rolling total initializing with a CTE
WITH Rolling_Total AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `MONTH`, 
        SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `MONTH`
    ORDER BY 1 ASC
)
SELECT 
    `MONTH`, 
    total_off,
    SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Group by company and order by total laid off descending (repeated query)
SELECT 
    company, 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Show the company, year, and sum columns
SELECT 
    company, 
    YEAR(`date`), 
    SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Using CTE to rank companies according to the year of laid off
WITH Company_Year AS (
    SELECT 
        company, 
        YEAR(`date`) AS years, 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
Company_Year_Rank AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
