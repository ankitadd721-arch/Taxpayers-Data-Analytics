CREATE DATABASE taxpayers_db;

USE taxpayers_db;

CREATE TABLE taxpayers (
    Taxpayer_ID VARCHAR(20) PRIMARY KEY,
    Gender VARCHAR(10),
    State VARCHAR(50),
    Age_Group VARCHAR(15),
    Filing_Type VARCHAR(50),
    Tax_Regime VARCHAR(20),
    Filing_Status VARCHAR(20),
    Assessment_Year VARCHAR(15),
    Gross_Income DECIMAL(15, 2),
    Total_Deductions DECIMAL(15, 2),
    Taxable_Income DECIMAL(15, 2),
    Tax_Paid DECIMAL(15, 2)
);

SELECT COUNT(*) AS total_rows FROM taxpayers;

-- ----------------------------Analysis--------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- 1: What is the overall summary of taxpayer filings, total revenue, and average tax paid?
-- ----------------------------------------------------------------------------------------------
SELECT 
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Tax_Paid) AS Total_Tax_Revenue,
    ROUND(AVG(Tax_Paid), 2) AS Avg_Tax_Paid,
    ROUND(AVG(Total_Deductions), 2) AS Avg_Deduction
FROM taxpayers;

-- ------------------------------------------------------------------------------------------
--  2:Find total filers and tax collected across different income groups?
-- ------------------------------------------------------------------------------------------
SELECT 
    CASE 
        WHEN Gross_Income < 500000 THEN 'Low Income (< 5L)'
        WHEN Gross_Income BETWEEN 500000 AND 1500000 THEN 'Middle Income (5L - 15L)'
        ELSE 'High Income (> 15L)'
    END AS Income_Slab,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Gross_Income) AS Total_Gross_Income,
    SUM(Tax_Paid) AS Total_Tax_Revenue,
    ROUND(AVG(Tax_Paid), 2) AS Avg_Tax_Paid
FROM taxpayers
GROUP BY Income_Slab
ORDER BY Total_Tax_Revenue DESC;

-- -----------------------------------------------------------------------------------
-- 3:Which are the top 5 states with the highest tax collection?-------
-- ----------------------------------------------------------------------------------
SELECT 
    State,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Tax_Paid) AS Total_Tax_Revenue,
    ROUND(AVG(Tax_Paid), 2) AS Avg_Tax_Paid
FROM taxpayers
GROUP BY State
ORDER BY Total_Tax_Revenue DESC
LIMIT 5;

-- -------------------------------------------------------------------------------------------------
-- 4: Compare tax collected and deductions claimed between Old and New Tax Regimes?
-- -------------------------------------------------------------------------------------------------
SELECT 
    Tax_Regime,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Total_Deductions) AS Total_Deductions_Claimed,
    SUM(Tax_Paid) AS Total_Tax_Collected
FROM taxpayers
GROUP BY Tax_Regime;


-- ---------------------------------------------------------------------------------------------
-- 5: Find filer count and tax collected by filing type and gender?
-- ---------------------------------------------------------------------------------------------
SELECT 
    Filing_Type,
    Gender,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Tax_Paid) AS Total_Tax_Revenue,
    ROUND(AVG(Tax_Paid), 2) AS Avg_Tax_Paid
FROM taxpayers
GROUP BY Filing_Type, Gender
ORDER BY Filing_Type, Total_Tax_Revenue DESC;