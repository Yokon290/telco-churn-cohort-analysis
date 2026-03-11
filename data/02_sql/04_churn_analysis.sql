-- =====================================================
-- 04_churn_analysis.sql
-- Purpose: Churn KPIs and segment analysis for dashboards
-- Source: clean.telco_churn
-- Outputs: analytics.* (views/tables)
-- =====================================================


-- =====================================================
-- Section A) Ad hoc KPI queries (quick checks)
-- =====================================================


-- A1) Overall churn KPIs (counts + churn rate)
-- Business question: What is the overall churn rate?

SELECT
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn;


-- A2) Churn by contract type
-- Business question: Which contract types have the highest churn

SELECT
  contract,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY contract
ORDER BY churn_rate_pct DESC;


-- A3) Churn by tenure cohort
-- Business question: Which tenure stage churn the most?

SELECT
  tenure_cohort,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY tenure_cohort
ORDER BY churn_rate_pct DESC;


-- A4) Churn by payment method
-- Business question: Does payment method influence churn?

SELECT
  payment_method,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY payment_method
ORDER BY churn_rate_pct DESC;


-- A5) Churn by internet service
-- Business question: Which internet service groups have the highest churn?

SELECT 
  internet_service,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY internet_service
ORDER BY churn_rate_pct DESC;


-- A6) Churn by tech support
-- Business question: Does tech support reduce churn?

SELECT
  tech_support,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY tech_support
ORDER BY churn_rate_pct DESC;


-- A7) Churn by online security
-- Business question: Does online security reduce churn?

SELECT
  online_security,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY online_security
ORDER BY churn_rate_pct DESC;


-- A8) Churn by senior citizen
-- Business question: Is churn higher among senior citizens?

SELECT
  CASE
     WHEN senior_citizen = 1 THEN 'Senior Citizen'
     ELSE 'Non-Senior'
  END AS senior_group,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY
  CASE
     WHEN senior_citizen = 1 THEN 'Senior Citizen'
     ELSE 'Non-Senior'
  END
ORDER BY churn_rate_pct DESC;


-- =====================================================
-- Section B) Analytics Views (for dashboards)
-- =====================================================


-- B1) Overall churn KPIs view

CREATE OR REPLACE VIEW analytics.churn_kpis AS
SELECT
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn;


-- B2) Churn by contract type

CREATE OR REPLACE VIEW analytics.churn_by_contract AS
SELECT
  contract,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY contract
ORDER BY churn_rate_pct DESC;


-- B3) Churn by tenure cohort

CREATE OR REPLACE VIEW analytics.churn_by_tenure AS
SELECT
  tenure_cohort,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY tenure_cohort
ORDER BY churn_rate_pct DESC;


-- B4) Churn by payment method

CREATE OR REPLACE VIEW analytics.churn_by_payment AS
SELECT
  payment_method,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY payment_method
ORDER BY churn_rate_pct DESC;


-- B5) Churn by internet service

CREATE OR REPLACE VIEW analytics.churn_by_internet_service AS
SELECT
  internet_service,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY internet_service
ORDER BY churn_rate_pct DESC;


-- B6) Churn by tech support

CREATE OR REPLACE VIEW analytics.churn_by_tech_support AS
SELECT
  tech_support,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY tech_support
ORDER BY churn_rate_pct DESC;


-- B7) Churn by online security

CREATE OR REPLACE VIEW analytics.churn_by_online_security AS
SELECT
  online_security,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY online_security
ORDER BY churn_rate_pct DESC;


-- B8) Churn by senior citizen

CREATE OR REPLACE VIEW analytics.churn_by_senior_citizen AS 
SELECT
  CASE
     WHEN senior_citizen = 1 THEN 'Senior Citizen'
     ELSE 'Non-Senior'
  END AS senior_group,
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * SUM(churn_flag)::numeric / COUNT(*), 2) AS churn_rate_pct
FROM clean.telco_churn
GROUP BY
  CASE
     WHEN senior_citizen = 1 THEN 'Senior Citizen'
     ELSE 'Non-Senior'
  END
ORDER BY churn_rate_pct DESC;