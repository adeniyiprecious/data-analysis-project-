-- 2.

WITH transaction_counts As (
Select
s.owner_id,
YEAR(s.transaction_date) As Year,
MONTH(s.transaction_date) As Month,
COUNT(s.transaction_date) As transaction_count
FROM savings_savingsaccount s
GROUP BY
s.owner_id,
YEAR(s.transaction_date), 
MONTH(s.transaction_date) 
),
average_transactions As (
Select
owner_id,
AVG(transaction_count) As avg_transactions_per_month
FROM transaction_counts
GROUP BY owner_id
)
Select
owner_id ,
avg_transactions_per_month,
CASE
WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
WHEN avg_transactions_per_month between 3 AND 9 THEN 'Medium Frequency'
WHEN avg_transactions_per_month <= 2 THEN 'Low Frequency'
END As frequency_category
FROM average_transactions
ORDER BY avg_transactions_per_month DESC;