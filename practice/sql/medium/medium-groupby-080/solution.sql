-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-07-30

WITH total_by_month AS (
    SELECT strftime('%Y-%m', transaction_date) AS month,
        COALESCE(SUM(CASE WHEN type = 'Thu' THEN amount END), 0) AS total_income,
        COALESCE(SUM(CASE WHEN type = 'Chi' THEN amount END), 0) AS total_expense
    FROM transactions
    GROUP BY month
)
SELECT
    month, total_income, total_expense,
    total_income - total_expense AS balance,
    SUM(total_income - total_expense) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_balance,
    CASE
        WHEN total_income - total_expense > 0 THEN 'Surplus'
        WHEN total_income - total_expense < 0 THEN 'Deficit'
        ELSE 'Balanced'
    END AS status
FROM total_by_month
ORDER BY month;
