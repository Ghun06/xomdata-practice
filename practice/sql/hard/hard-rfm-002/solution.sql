-- Xom Data · Assigning customers to the right care segment
-- Problem: https://xomdata.com/practice/hard-rfm-002
-- Solved: 2026-11-24


WITH customer_stats AS (
    SELECT
        customer_id,
        MAX(order_date::DATE) AS last_order_date,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)

SELECT
    customer_id,

    DATE '2024-06-30' - last_order_date AS days_since,

    order_count,

    CASE
        WHEN DATE '2024-06-30' - last_order_date <= 60
             AND order_count >= 3
            THEN 'Champions'

        WHEN DATE '2024-06-30' - last_order_date > 60
             AND order_count >= 3
            THEN 'At Risk'

        WHEN DATE '2024-06-30' - last_order_date <= 60
             AND order_count < 3
            THEN 'Promising'

        ELSE 'Hibernating'
    END AS segment

FROM customer_stats;
