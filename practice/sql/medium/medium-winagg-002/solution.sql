-- Xom Data · Product share within its store
-- Problem: https://xomdata.com/practice/medium-winagg-002
-- Solved: 2026-08-06

-- Viết SQL của bạn ở đây
SELECT store, product, amount, ROUND(amount * 100.0/ SUM(amount) OVER(PARTITION BY store),2) AS pct_of_store
FROM store_sales
ORDER BY store, product ASC;
