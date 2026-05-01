--Q1 
SELECT clean_status, COUNT(*) FROM transactions GROUP BY clean_status;
--Q2 
SELECT clean_merchant_name, SUM(amount_usd) AS total_captured_gmv FROM transactions WHERE clean_status = 'Captured' GROUP BY clean_merchant_name;
--Q3 
SELECT clean_merchant_name, SUM(amount_usd) AS total_captured_gmv FROM transactions WHERE clean_status = 'Captured' GROUP BY clean_merchant_name ORDER BY total_captured_gmv DESC LIMIT 10;
--Q4 
SELECT clean_transaction_date, SUM(amount_usd), COUNT(*) FROM transactions WHERE clean_status = 'Captured' GROUP BY clean_transaction_date;
--Q5 
SELECT clean_merchant_name, (COUNT(transaction_id) * 100.0 / (SELECT COUNT(*) FROM transactions AS t2 WHERE t2.clean_merchant_name = transactions.clean_merchant_name)) AS chargeback_ratio FROM transactions WHERE clean_status = 'Chargeback' GROUP BY clean_merchant_name HAVING chargeback_ratio > 1;
--Q6 
SELECT clean_gateway_region, AVG(clean_risk_score) FROM transactions WHERE clean_risk_score > 0 GROUP BY clean_gateway_region HAVING AVG(clean_risk_score) > 50 AND COUNT(*) > 20;
--Q7 
SELECT user_id, clean_transaction_date, COUNT(*) FROM transactions WHERE clean_status IN ('Failed E05 Timeout', 'Chargeback') GROUP BY user_id, clean_transaction_date HAVING COUNT(*) >= 3; 
--Q8 
SELECT clean_merchant_name, COUNT(*), COUNT(DISTINCT user_id), SUM(amount_usd) FROM transactions WHERE clean_status = 'Chargeback' GROUP BY clean_merchant_name;
-- NOTE TABLE NAME IS CREATED AS 'transactions'
