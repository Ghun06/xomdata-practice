-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-05-26

-- Viết SQL của bạn ở đây
WITH monthly_summary AS (
    SELECT
        strftime('%Y-%m', transaction_date) AS month,
        COUNT(*) AS transaction_count,
        SUM(amount) AS total_amount
    FROM transactions
    GROUP BY strftime('%Y-%m', transaction_date)
)

SELECT
    month,
    transaction_count,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        ORDER BY month
    ) AS mom_delta
FROM monthly_summary
ORDER BY month ASC;
