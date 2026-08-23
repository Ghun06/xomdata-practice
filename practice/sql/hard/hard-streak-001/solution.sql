-- Xom Data · Longest run of consecutive active months
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-08-23

WITH monthly_orders AS (
    SELECT DISTINCT
        customer_id,
        strftime('%Y-%m-01', order_date) AS order_month
    FROM orders
),

numbered AS (
    SELECT customer_id, order_month,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_month
        ) AS rn
    FROM monthly_orders
),

grouped AS (
    SELECT customer_id,
        date(order_month, '-' || rn || ' months') AS group_key
    FROM numbered
),

streaks AS (
    SELECT customer_id, group_key, COUNT(*) AS streak_length
    FROM grouped
    GROUP BY customer_id, group_key
)

SELECT
    customer_id,
    MAX(streak_length) AS longest_streak
FROM streaks
GROUP BY customer_id
ORDER BY
    longest_streak DESC,
    customer_id ASC;
