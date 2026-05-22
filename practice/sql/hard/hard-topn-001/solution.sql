-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-05-22

-- Viết SQL của bạn ở đây
SELECT * FROM (
    SELECT category, name AS product_name, units_sold,
    DENSE_RANK () OVER (PARTITION BY category ORDER BY units_sold DESC) as rank_in_cat
    FROM products
) t
WHERE rank_in_cat <= 3
ORDER BY category, rank_in_cat, product_name
