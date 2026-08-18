-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-08-18

WITH cutoff AS (
    SELECT MAX(order_date) AS cutoff_date
    FROM orders
),
last_orders AS (
    SELECT
        user_id,
        MAX(order_date) AS last_order_date
    FROM orders
    GROUP BY user_id
)
SELECT
    lo.user_id,
    lo.last_order_date,
    julianday(c.cutoff_date) - julianday(lo.last_order_date) AS days_since_last
FROM last_orders lo
CROSS JOIN cutoff c
WHERE julianday(c.cutoff_date) - julianday(lo.last_order_date) >= 90
ORDER BY days_since_last DESC, lo.user_id ASC;
