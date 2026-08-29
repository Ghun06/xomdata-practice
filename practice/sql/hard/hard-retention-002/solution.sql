-- Xom Data · How much is left after one month
-- Problem: https://xomdata.com/practice/hard-retention-002
-- Solved: 2026-08-29

WITH customer_cohorts AS (
    SELECT
        customer_id,
        date(MIN(order_date), 'start of month') AS cohort_start
    FROM orders
    GROUP BY customer_id
),

customer_retention AS (
    SELECT
        c.customer_id,
        c.cohort_start,
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM orders o
                WHERE o.customer_id = c.customer_id
                  AND date(o.order_date, 'start of month')
                      = date(c.cohort_start, '+1 month')
            )
            THEN 1
            ELSE 0
        END AS retained_m1
    FROM customer_cohorts c
)

SELECT
    strftime('%Y-%m', cohort_start) AS cohort_month,
    COUNT(*) AS cohort_size,
    SUM(retained_m1) AS retained_m1,
    ROUND(
        100.0 * SUM(retained_m1) / COUNT(*),
        2
    ) AS retention_pct
FROM customer_retention
GROUP BY cohort_start
ORDER BY cohort_start;
