-- Xom Data · Subscriber churn rhythm by month
-- Problem: https://xomdata.com/practice/hard-churn-004
-- Solved: 2026-08-30

WITH months AS (
    SELECT DISTINCT
        date(end_date, 'start of month') AS month_start
    FROM subscriptions
    WHERE end_date IS NOT NULL
),

monthly_stats AS (
    SELECT
        m.month_start,
        SUM(
            CASE
                WHEN s.start_date < m.month_start
                 AND (s.end_date IS NULL OR s.end_date >= m.month_start)
                THEN 1
                ELSE 0
            END
        ) AS active_at_start,
        
        SUM(
            CASE
                WHEN s.end_date >= m.month_start
                 AND s.end_date < date(m.month_start, '+1 month')
                THEN 1
                ELSE 0
            END
        ) AS ended_subs

    FROM months m
    CROSS JOIN subscriptions s
    GROUP BY m.month_start
)

SELECT
    strftime('%Y-%m', month_start) AS month,
    active_at_start,
    ended_subs,
    CASE
        WHEN active_at_start = 0 THEN NULL
        ELSE ROUND(ended_subs * 100.0 / active_at_start, 2)
    END AS churn_rate_pct
FROM monthly_stats
ORDER BY month_start;
