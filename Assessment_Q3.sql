-- Q3: Account Inactivity Alert

WITH savings_last_txn AS (
    SELECT
        sa.plan_id,
        sa.owner_id,
        MAX(sa.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount sa
    WHERE sa.confirmed_amount IS NOT NULL
    GROUP BY sa.plan_id, sa.owner_id
),
investment_last_txn AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        p.last_returns_date AS last_transaction_date
    FROM plans_plan p
    WHERE p.is_a_fund = 1
)

SELECT
    plan_id,
    owner_id,
    'Savings' AS type,
    last_transaction_date,
    DATEDIFF(CURRENT_DATE, last_transaction_date) AS inactivity_days
FROM savings_last_txn
WHERE DATEDIFF(CURRENT_DATE, last_transaction_date) > 365

UNION

SELECT
    plan_id,
    owner_id,
    'Investment' AS type,
    last_transaction_date,
    DATEDIFF(CURRENT_DATE, last_transaction_date) AS inactivity_days
FROM investment_last_txn
WHERE last_transaction_date IS NOT NULL
  AND DATEDIFF(CURRENT_DATE, last_transaction_date) > 365;
