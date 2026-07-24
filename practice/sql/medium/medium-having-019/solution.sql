-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-07-24

WITH factb AS (
    SELECT store_name, reputation_score, COUNT(*) AS order_count
    FROM sellers
    JOIN orders ON sellers.id = orders.seller_id
    WHERE reputation_score >= 4.5
    GROUP BY store_name
    HAVING COUNT(*) >= 3
)
SELECT *, 
    DENSE_RANK() OVER(ORDER BY order_count DESC) AS rank_by_orders, 
    SUM(order_count) OVER(ORDER BY order_count DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_orders
FROM factb
