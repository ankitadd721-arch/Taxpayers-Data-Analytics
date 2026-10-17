# Taxpayers-Data-Analytics
Analyzing tax filing trends and behavior using MySQL &amp; Power BI

# Taxpayers Data Analytics — Uncovering Revenue Trends & Taxpayer Behavior

An end-to-end data analytics project leveraging **MySQL** for schema design and complex aggregations, and **Power BI** for executive dashboard reporting and demographic analysis.

---

## 📌 Project Overview
Tax administrations process millions of filings annually, making it challenging to identify overarching revenue patterns and evaluate the impact of deductions. This project models and analyzes tax filing records across multiple demographics, income slabs, and tax regimes to provide clear business insights for policy and resource optimization.

---

## 🛠️ Tech Stack & Tools
* **Database / Querying:** MySQL Workbench
* **Business Intelligence & Visualization:** Power BI Desktop, DAX
* **Data Concepts:** Relational Schema, Conditional Logic, Multi-Level Aggregation, Slicers & Cross-filtering

---

## 📊 Analytical Methodology

### 1. Data Sourcing & Schema Design
* **Dataset:** 1,000 structured tax filing records.
* **Attributes:** `Taxpayer_ID`, `Gender`, `State`, `Age_Group`, `Filing_Type`, `Gross_Income`, `Total_Deductions`, `Tax_Paid`, `Tax_Regime`, `Assessment_Year`.
* **Validation:** Verified complete records with zero null values across core numeric fields.

### 2. SQL Analytical Layer
* **Conditional Logic:** Segmented taxpayers into `Low Income (< 5L)`, `Middle Income (5L - 15L)`, and `High Income (> 15L)`.
* **Aggregations:** Grouped metrics to analyze revenue collection by state, filing category, and tax regime.

### 3. Power BI Executive Dashboard
* **DAX KPI Measures:** Total Revenue, Total Filers, Average Tax Paid, and Total Deductions Claimed.
* **Interactivity:** Configured dynamic slicers (Assessment Year, Gender) and cross-filtering visual charts.

---

## 💡 Key SQL Queries

```sql
-- 1. Income Slab Segmentation
SELECT 
    CASE 
        WHEN Gross_Income < 500000 THEN 'Low Income (< 5L)'
        WHEN Gross_Income BETWEEN 500000 AND 1500000 THEN 'Middle Income (5L - 15L)'
        ELSE 'High Income (> 15L)'
    END AS Income_Slab,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Tax_Paid) AS Total_Revenue,
    ROUND(AVG(Tax_Paid), 2) AS Avg_Tax_Paid
FROM taxpayers
GROUP BY Income_Slab
ORDER BY Total_Revenue DESC;

-- 2. Old vs. New Tax Regime Analysis
SELECT 
    Tax_Regime,
    COUNT(Taxpayer_ID) AS Total_Filers,
    SUM(Total_Deductions) AS Total_Deductions_Claimed,
    SUM(Tax_Paid) AS Total_Tax_Collected
FROM taxpayers
GROUP BY Tax_Regime;


