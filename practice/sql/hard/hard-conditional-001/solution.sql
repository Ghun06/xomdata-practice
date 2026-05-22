-- Xom Data · Cumulative revenue from successful transactions only
-- Problem: https://xomdata.com/practice/hard-conditional-001
-- Solved: 2026-05-22

-- Viết SQL của bạn ở đây
SELECT date, status, amount,
       SUM (Case WHEN status = 'success' THEN amount
                 ELSE 0 END) OVER(
        ORDER BY date, status
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_success_total
FROM transactions
ORDER BY date, status
