-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-05-22

-- Viết SQL của bạn ở đây
SELECT strftime('%Y-%m', sale_date) AS 'month',
      SUM(CASE WHEN category = 'Electronics' THEN amount ELSE 0 END) AS electronics,
      SUM(CASE WHEN category = 'Clothing' THEN amount ELSE 0 END) AS clothing,
      SUM(CASE WHEN category = 'Food' THEN amount ELSE 0 END) AS food,
      SUM(amount) AS total
FROM sales
GROUP BY strftime('%Y-%m', sale_date)
ORDER BY 'month';
