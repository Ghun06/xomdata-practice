-- Xom Data · Monthly recurring revenue (MRR) by subscription plan
-- Problem: https://xomdata.com/practice/hard-mrr-001
-- Solved: 2026-08-18

WITH RECURSIVE bounds AS (
    SELECT
        date(MIN(started_at), 'start of month') AS min_month,
        date(MAX(started_at), 'start of month') AS max_month
    FROM subscriptions
),
months AS (
    SELECT min_month AS month_start
    FROM bounds

    UNION ALL

    SELECT date(month_start, '+1 month')
    FROM months, bounds
    WHERE date(month_start, '+1 month') <= max_month
),
month_ends AS (
    SELECT
        strftime('%Y-%m', month_start) AS month,
        date(month_start, '+1 month', '-1 day') AS eom
    FROM months
)
SELECT
    me.month,
    COUNT(s.user_id) AS active_subs,
    COALESCE(SUM(s.mrr), 0) AS total_mrr
FROM month_ends me
LEFT JOIN subscriptions s
    ON s.started_at <= me.eom
    AND (s.ended_at IS NULL OR s.ended_at > me.eom)
GROUP BY me.month
ORDER BY me.month ASC;
