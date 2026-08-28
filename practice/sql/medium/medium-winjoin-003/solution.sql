-- Xom Data · Each aisle's best seller
-- Problem: https://xomdata.com/practice/medium-winjoin-003
-- Solved: 2026-08-28

-- Viết SQL của bạn ở đây
SELECT category_name, product_name, units_sold
FROM (
    SELECT category_name, product_name, units_sold,
        ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY units_sold DESC, product_name ASC) AS rnk
    FROM products JOIN categories ON products.category_id = categories.id
)
WHERE rnk = 1
ORDER BY category_name ASC;
