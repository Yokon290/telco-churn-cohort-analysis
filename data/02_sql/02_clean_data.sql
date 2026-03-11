-- =====================================================
-- 02_clean_data.sql
-- Build trusted cleaned table
-- Target: clean.telco_churn
-- Source: raw.telco_churn_stg
-- =====================================================

DROP TABLE IF EXISTS clean.telco_churn;

CREATE TABLE clean.telco_churn AS

SELECT
  BTRIM(customer_id) AS customer_id,
  
  BTRIM(gender) AS gender,
  
  senior_citizen::int AS senior_citizen,
  
  BTRIM(partner) AS partner,
  BTRIM(dependents) AS dependents,
  
  tenure::int AS tenure,
  
  BTRIM(phone_service) AS phone_service,
  BTRIM(multiple_lines) AS multiple_lines,
  
  BTRIM(internet_service) AS internet_service,
  BTRIM(online_security) AS online_security,
  BTRIM(online_backup) AS online_backup,
  BTRIM(device_protection) AS device_protection,
  BTRIM(tech_support) AS tech_support,
  BTRIM(streaming_tv) AS streaming_tv,
  BTRIM(streaming_movies) AS streaming_movies,
  
  BTRIM(contract) AS contract,
  BTRIM(paperless_billing) AS paperless_billing,
  BTRIM(payment_method) AS payment_method,
  
  monthly_charges::numeric AS monthly_charges,
  
  NULLIF(BTRIM(total_charges), '')::numeric AS total_charges,
  
  BTRIM(churn) AS churn,
  
  CASE 
      WHEN BTRIM(churn) = 'Yes' THEN 1 
      ELSE 0 
  END AS churn_flag,
  
  CASE
      WHEN tenure::int <= 12 THEN '0-12 months'
      WHEN tenure::int <= 24 THEN '13-24 months'
      WHEN tenure::int <= 48 THEN '25-48 months'
      ELSE '49+ months'
  END AS tenure_cohort

FROM raw.telco_churn_stg;
