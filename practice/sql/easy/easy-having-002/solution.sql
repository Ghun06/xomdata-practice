-- Xom Data · Customers reaching the loyalty milestone
-- Problem: https://xomdata.com/practice/easy-having-002
-- Solved: 2026-08-13

-- Viết SQL của bạn ở đây
SELECT customer_name, SUM(amount) AS total_spent
FROM purchases
GROUP BY customer_name
HAVING SUM(amount) >= 5000000
ORDER BY total_spent DESC, customer_name ASC;
