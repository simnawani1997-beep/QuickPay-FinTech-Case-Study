## Q1
### Query
SELECT clean_status, COUNT(*) 
FROM transactions 
GROUP BY clean_status;
### Result Summary
The dataset consists of 30 transactions: 19 Captured, 7 Failed E05 Timeout, and 4 Chargebacks.
## Q2
### Query
SELECT clean_merchant_name, SUM(amount_usd) AS total_captured_gmv 
FROM transactions 
WHERE clean_status = 'Captured' 
GROUP BY clean_merchant_name;
### Result Summary
This query identifies the total successful revenue (Captured GMV) for each merchant. The data shows that Beta Stores processed $33,141.50 and Alpha Mart processed $29,928.50, while Delta Travels and City Pharma contributed $10,300.00 and $8,640.00 respectively.
## Q3
### Query
SELECT clean_merchant_name, SUM(amount_usd) AS total_captured_gmv 
FROM transactions 
WHERE clean_status = 'Captured' 
GROUP BY clean_merchant_name 
ORDER BY total_captured_gmv DESC 
LIMIT 10;
#### Result Summary
By ranking the merchants, we see that Beta Stores is the top-performing merchant by volume. The top two merchants (Beta Stores and Alpha Mart) account for over 75% of the total captured revenue in this sample.
## Q4
### Query
SELECT clean_transaction_date, SUM(amount_usd), COUNT(*) 
FROM transactions 
WHERE clean_status = 'Captured' 
GROUP BY clean_transaction_date;
### Result Summary
Daily GMV peaked on 2026-03-01 with $26,382.00 across 5 successful transactions. Activity remained consistent throughout the week with at least one successful transaction daily.
## Q5
### Query
SELECT clean_merchant_name, 
       (COUNT(transaction_id) * 100.0 / 
        (SELECT COUNT(*) 
         FROM transactions AS t2 
         WHERE t2.clean_merchant_name = transactions.clean_merchant_name)
       ) AS chargeback_ratio
FROM transactions
WHERE clean_status = 'Chargeback'
GROUP BY clean_merchant_name
HAVING chargeback_ratio > 1;
### Result Summary
This query identifies merchants whose dispute rates exceed the 1% industry safety threshold. Eco Home (50%), Delta Travels (25%), and Alpha Mart/Beta Stores (9.09%) are all in the high-risk zone, suggesting a need for stricter fraud controls.
## Q6
### Query
SELECT clean_gateway_region, AVG(clean_risk_score) 
FROM transactions 
WHERE clean_risk_score > 0 
GROUP BY clean_gateway_region
HAVING AVG(clean_risk_score) > 50 AND COUNT(*) > 20;
### Result Summary
The APAC region is the only one meeting both criteria, with an average risk score of 65.47 and 22 transactions. This identifies APAC as a high-volume, higher-risk region for the business.
## Q7
### Query
SELECT user_id, clean_transaction_date, COUNT(*) 
FROM transactions 
WHERE clean_status IN ('Failed E05 Timeout', 'Chargeback') 
GROUP BY user_id, clean_transaction_date
HAVING COUNT(*) >= 3;
### Result Summary
User U008 was flagged for high-frequency issues on 2026-03-05, recording 4 failed or chargeback transactions on a single day.
## Q8
### Query
SELECT clean_merchant_name, COUNT(*), COUNT(DISTINCT user_id), SUM(amount_usd) 
FROM transactions 
WHERE clean_status = 'Chargeback' 
GROUP BY clean_merchant_name;
### Result Summary
Total losses due to chargebacks amounted to $16,168.50. While four merchants recorded disputes, Eco Home had the highest individual financial impact at $6,588.00.
