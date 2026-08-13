-- Xom Data · Categories full enough for the homepage
-- Problem: https://xomdata.com/practice/easy-having-001
-- Solved: 2026-08-13

-- Viết SQL của bạn ở đây
SELECT category, COUNT(*) AS num_products
FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY category ASC;
