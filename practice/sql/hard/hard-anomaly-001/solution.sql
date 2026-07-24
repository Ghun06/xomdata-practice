-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-07-24

WITH stats AS (
    SELECT
        AVG(value) AS mean
    FROM daily_metrics
),
calc AS (
    SELECT
        SQRT(AVG((d.value - s.mean) * (d.value - s.mean))) AS stddev
    FROM daily_metrics d
    CROSS JOIN stats s
)
SELECT
    d.date,
    d.value,
    ROUND(s.mean, 2) AS mean,
    ROUND(c.stddev, 2) AS stddev,
    ROUND(
        CASE
            WHEN c.stddev = 0 THEN 0
            ELSE (d.value - s.mean) / c.stddev
        END,
        2
    ) AS z_score,
    CASE
        WHEN c.stddev = 0 THEN 'normal'
        WHEN (d.value - s.mean) / c.stddev > 2 THEN 'high'
        WHEN (d.value - s.mean) / c.stddev < -2 THEN 'low'
        ELSE 'normal'
    END AS flag
FROM daily_metrics d
CROSS JOIN stats s
CROSS JOIN calc c
ORDER BY d.date;
