-- Step-by-step efficient approach

SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COALESCE(s.savings_count, 0) AS savings_count,
    COALESCE(i.investment_count, 0) AS investment_count,
    ROUND(COALESCE(sa.total_deposits, 0) / 100, 2) AS total_deposits
FROM users_customuser u

-- Subquery: count savings plans per user
LEFT JOIN (
    SELECT owner_id, COUNT(*) AS savings_count
    FROM plans_plan
    WHERE is_regular_savings = 1
    GROUP BY owner_id
) s ON s.owner_id = u.id

-- Subquery: count investment plans per user
LEFT JOIN (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
) i ON i.owner_id = u.id

-- Subquery: sum of confirmed deposits
LEFT JOIN (
    SELECT owner_id, SUM(confirmed_amount) AS total_deposits
    FROM savings_savingsaccount
    WHERE confirmed_amount IS NOT NULL
    GROUP BY owner_id
) sa ON sa.owner_id = u.id

-- Only show users with both savings and investments
WHERE COALESCE(s.savings_count, 0) > 0
  AND COALESCE(i.investment_count, 0) > 0

ORDER BY total_deposits DESC;
