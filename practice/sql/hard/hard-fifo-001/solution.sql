-- Xom Data · Running inventory balance over time
-- Problem: https://xomdata.com/practice/hard-fifo-001
-- Solved: 2026-05-22

-- Viết SQL của bạn ở đây
SELECT sku, occurred_at, type, quantity,
    SUM(CASE WHEN type = 'IN' THEN quantity ELSE -quantity END) 
    OVER(PARTITION BY sku ORDER BY occurred_at, type ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    AS running_balance
FROM inventory_movements
ORDER BY sku, occurred_at;
