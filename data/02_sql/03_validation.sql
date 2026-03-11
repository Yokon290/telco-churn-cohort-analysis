-- =========================================================
-- 03_validation.sql
-- Validate clean.telco_churn
-- =========================================================

-- 1) Row count + primary key uniqueness check
SELECT 
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customer_id) AS distinct_customer,
  COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_rows
FROM clean.telco_churn;

-- 2) Validate churn_flag matches churn values
SELECT
  churn,
  churn_flag,
  COUNT(*) AS customers
FROM clean.telco_churn
GROUP BY churn, churn_flag
ORDER BY churn, churn_flag;

-- 3) Validate Total Charges NULL handling
SELECT
  COUNT(*) AS total_rows,
  COUNT(total_charges) AS non_null_total_charges,
  COUNT(*) - COUNT(total_charges) AS null_total_charges
FROM clean.telco_churn;

-- 4) Validate tenure cohort distribution
SELECT 
  tenure_cohort,
  COUNT(*) AS customers
FROM clean.telco_churn
GROUP BY tenure_cohort
ORDER BY tenure_cohort;