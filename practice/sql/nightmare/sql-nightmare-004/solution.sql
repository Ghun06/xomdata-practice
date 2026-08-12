-- Xom Data · Frequently co-purchased product pairs
-- Problem: https://xomdata.com/practice/sql-nightmare-004
-- Solved: 2026-08-12

WITH user_products AS (
    SELECT DISTINCT user_id, product_id
    FROM orders
)
SELECT
    a.product_id AS product_a,
    b.product_id AS product_b,
    COUNT(DISTINCT a.user_id) AS co_buyers
FROM user_products a
JOIN user_products b
    ON a.user_id = b.user_id
   AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY co_buyers DESC, product_a ASC, product_b ASC;
