-- Q4: Customer Lifetime Value (CLV) Estimation

WITH txn_data AS (
    SELECT
        sa.owner_id,
        COUNT(*) AS total_transactions,
        ROUND(AVG(sa.confirmed_amount * 0.001), 2) AS avg_profit_per_transaction
    FROM savings_savingsaccount sa
    WHERE sa.confirmed_amount IS NOT NULL
    GROUP BY sa.owner_id
),
tenure_data AS (
    SELECT
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months
    FROM users_customuser u
)

SELECT
    t.customer_id,
    t.name,
    t.tenure_months,
    tx.total_transactions,
    ROUND((tx.total_transactions / t.tenure_months) * 12 * tx.avg_profit_per_transaction, 2) AS estimated_clv
FROM tenure_data t
JOIN txn_data tx ON t.customer_id = tx.owner_id
WHERE t.tenure_months > 0
ORDER BY estimated_clv DESC;
