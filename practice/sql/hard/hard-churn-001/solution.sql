-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-05-25

-- Viết SQL của bạn ở đây
WITH ftb AS (
SELECT user_id, order_date AS prev_order, LAG(order_date, -1, 0) OVER (PARTITION BY user_id ORDER BY order_date) as next_order
FROM orders
),
factb AS (
SELECT user_id, prev_order, next_order,
      CAST(JULIANDAY(next_order) - JULIANDAY(prev_order) AS INTEGER) AS gap_days 
FROM ftb
WHERE next_order != 0
)
SELECT user_id, prev_order, next_order, gap_days FROM factb
WHERE gap_days >= 90
ORDER BY gap_days DESC, user_id
