-- Xom Data · Classify products by sales velocity
-- Problem: https://xomdata.com/practice/medium-case-110
-- Solved: 2026-05-29

-- Viết SQL của bạn ở đây
WITH factb AS (
    SELECT name, categories, SUM(quantity) AS total_sold,
    CASE WHEN SUM(quantity) >= 100 THEN 'Best Seller'
         WHEN SUM(quantity) >= 50 THEN 'Average'
         ELSE 'Slow Mover' END AS classification
    FROM products ps 
    JOIN transactions ts ON ps.id = ts.product_id
    GROUP BY name, categories
)
SELECT *, DENSE_RANK() OVER(PARTITION BY categories ORDER BY total_sold DESC) AS rank_in_cat,
ROUND(total_sold * 100.0/SUM(total_sold) OVER(PARTITION BY categories), 2) AS pct_of_cat_total
FROM factb
ORDER BY categories, rank_in_cat, name ASC;
