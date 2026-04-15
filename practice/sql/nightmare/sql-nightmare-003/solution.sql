-- Xom Data · 3-month consecutive disbursement rate by department
-- Problem: https://xomdata.com/practice/sql-nightmare-003
-- Solved: 2026-04-15

-- Viết query của bạn ở đây
With factb as (
SELECT dept, month, 
SUM(budget) OVER (PARTITION BY dept ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_budget,
SUM(actual) OVER (PARTITION BY dept ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_actual
FROM budgets
GROUP BY dept, month
)
SELECT *, ROUND((roll3_actual * 100.0/roll3_budget), 2) AS utilization_pct
FROM factb
