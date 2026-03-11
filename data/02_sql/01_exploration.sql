-- =========================================================
-- 01_exploration.sql
-- Telco Churn (RAW) - Data Profiling / Exploration
-- Source table: raw.telco_churn_stg
-- Goal: understand shape, quality issues, and value ranges
-- =========================================================

-- 1) Row count
SELECT COUNT(*) AS row_count
FROM raw.telco_churn_stg;

-- 2) Primary key check
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customer_id) AS distinct_customer,
  COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_rows
FROM raw.telco_churn_stg;

-- 3) Show duplicates
SELECT customer_id, COUNT(*) AS cnt
FROM raw.telco_churn_stg
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- 4) Quick peek
SELECT *
FROM raw.telco_churn_stg
LIMIT 20;

-- 5) Check for blanks / NULLs in important fields
SELECT
  SUM(CASE WHEN customer_id IS NULL OR BTRIM(customer_id) = '' THEN 1 ELSE 0 END) AS blank_customer_id,
  SUM(CASE WHEN tenure IS NULL OR BTRIM(tenure) = '' THEN 1 ELSE 0 END) AS blank_tenure,
  SUM(CASE WHEN monthly_charges IS NULL OR BTRIM(monthly_charges) = '' THEN 1 ELSE 0 END) AS blank_monthly_charges,
  SUM(CASE WHEN total_charges IS NULL OR BTRIM(total_charges) = '' THEN 1 ELSE 0 END) AS blank_total_charges,
  SUM(CASE WHEN churn IS NULL OR BTRIM(churn) = '' THEN 1 ELSE 0 END) AS blank_churn
FROM raw.telco_churn_stg;

-- 6) Churn distribution (raw)
SELECT churn, COUNT(*) AS customers
FROM raw.telco_churn_stg
GROUP BY churn
ORDER BY customers DESC;

-- 7) Check key categorical columns for unexpected values
SELECT gender, COUNT(*)
FROM raw.telco_churn_stg
GROUP BY gender 
ORDER BY COUNT(*) DESC;

SELECT senior_citizen, COUNT(*)
FROM raw.telco_churn_stg
GROUP BY senior_citizen
ORDER BY COUNT(*) DESC;

SELECT contract, COUNT(*)
FROM raw.telco_churn_stg
GROUP BY contract
ORDER BY COUNT(*) DESC;

SELECT payment_method, COUNT(*)
FROM raw.telco_churn_stg
GROUP BY payment_method
ORDER BY COUNT(*) DESC;

SELECT internet_service, COUNT(*)
FROM raw.telco_churn_stg
GROUP BY internet_service
ORDER BY COUNT(*) DESC;

-- 8) Numeric "sanity checks" before conversion

-- tenure
SELECT tenure
FROM raw.telco_churn_stg
WHERE BTRIM(tenure) !~ '^\d+$'
LIMIT 50;

-- monthly_charges
SELECT monthly_charges
FROM raw.telco_churn_stg
WHERE BTRIM(monthly_charges) !~ '^\d+(\.\d+)?$'
LIMIT 50;

-- total_charges
SELECT total_charges
FROM raw.telco_churn_stg
WHERE BTRIM(total_charges) <> ''
  AND BTRIM(total_charges) !~ '^\d+(\.\d+)?$'
LIMIT 50;

-- 9) Relationship check
SELECT 
  COUNT(*) AS blank_totalcharges_rows,
  SUM(CASE WHEN BTRIM(tenure) = '0' THEN 1 ELSE 0 END) AS tenure_zero_rows
FROM raw.telco_churn_stg
WHERE BTRIM(total_charges) = '';

-- 10) Quick tenure distribution
SELECT tenure, COUNT(*) AS customers
FROM raw.telco_churn_stg
GROUP BY tenure
ORDER BY tenure::int NULLS LAST;