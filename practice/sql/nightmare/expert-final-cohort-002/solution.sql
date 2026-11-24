-- Xom Data · Next-month customer retention rate by cohort
-- Problem: https://xomdata.com/practice/expert-final-cohort-002
-- Solved: 2026-11-24


WITH monthly_users AS (
    -- Lấy danh sách user duy nhất theo từng tháng
    SELECT DISTINCT
        TO_CHAR(order_date::DATE, 'YYYY-MM') AS first_month,
        user_id
    FROM orders
),

retention AS (
    -- Ghép người dùng tháng hiện tại với tháng kế tiếp
    SELECT
        m1.first_month,
        COUNT(DISTINCT m1.user_id) AS first_month_users,
        COUNT(DISTINCT m2.user_id) AS return_count
    FROM monthly_users m1
    LEFT JOIN monthly_users m2
        ON m1.user_id = m2.user_id
        AND TO_DATE(m2.first_month, 'YYYY-MM') =
            (TO_DATE(m1.first_month, 'YYYY-MM') + INTERVAL '1 month')
    GROUP BY m1.first_month
)

SELECT
    first_month,
    first_month_users,
    return_count,
    ROUND(
        return_count * 100.0 / NULLIF(first_month_users, 0),
        1
    ) AS retention_rate
FROM retention
ORDER BY first_month;
