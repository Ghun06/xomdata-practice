-- Xom Data · Kênh nào mua về khách bền nhất
-- Problem: https://xomdata.com/practice/hard-retention-009
-- Solved: 2026-08-28

WITH first_purchase AS (
    SELECT
        customer_id,
        date(MIN(order_date), 'start of month') AS cohort_month
    FROM orders
    GROUP BY customer_id
),

customer_cohort AS (
    SELECT
        c.customer_id,
        c.channel,
        fp.cohort_month
    FROM customers c
    JOIN first_purchase fp
        ON c.customer_id = fp.customer_id
),

customer_retention AS (
    SELECT
        cc.customer_id,
        cc.channel,
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM orders o
                WHERE o.customer_id = cc.customer_id
                  AND date(o.order_date, 'start of month')
                      = date(cc.cohort_month, '+1 month')
            )
            THEN 1
            ELSE 0
        END AS retained
    FROM customer_cohort cc
)

SELECT
    channel,
    COUNT(*) AS cohort_customers,
    SUM(retained) AS retained,
    ROUND(
        100.0 * SUM(retained) / COUNT(*),
        2
    ) AS retention_pct
FROM customer_retention
GROUP BY channel
ORDER BY retention_pct DESC, channel ASC;
