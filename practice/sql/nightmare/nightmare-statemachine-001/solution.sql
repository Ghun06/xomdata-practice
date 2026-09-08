-- Xom Data · Advertiser status by month (4 states)
-- Problem: https://xomdata.com/practice/nightmare-statemachine-001
-- Solved: 2026-09-08

WITH RECURSIVE months(month) AS (
  SELECT (SELECT MIN(month) FROM advertiser_activity)
  UNION ALL
  SELECT strftime('%Y-%m', date(month || '-01', '+1 month'))
  FROM months
  WHERE month < (SELECT MAX(month) FROM advertiser_activity)
),
advertisers AS (
  SELECT DISTINCT advertiser_id FROM advertiser_activity
),
grid AS (
  SELECT a.advertiser_id, m.month
  FROM advertisers a
  CROSS JOIN months m
),
joined AS (
  SELECT
    g.advertiser_id,
    g.month,
    CASE WHEN aa.advertiser_id IS NOT NULL THEN 1 ELSE 0 END AS is_active
  FROM grid g
  LEFT JOIN advertiser_activity aa
    ON aa.advertiser_id = g.advertiser_id
   AND aa.month = g.month
),
calc AS (
  SELECT
    advertiser_id,
    month,
    is_active,
    LAG(is_active) OVER (PARTITION BY advertiser_id ORDER BY month) AS prev_active,
    MAX(is_active) OVER (
      PARTITION BY advertiser_id ORDER BY month
      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) AS ever_active_before
  FROM joined
)
SELECT
  advertiser_id,
  month,
  CASE
    WHEN is_active = 1 AND (ever_active_before IS NULL OR ever_active_before = 0) THEN 'NEW'
    WHEN is_active = 1 AND prev_active = 1 THEN 'EXISTING'
    WHEN is_active = 1 AND prev_active = 0 THEN 'RESURRECT'
    WHEN is_active = 0 AND prev_active = 1 THEN 'CHURN'
  END AS state
FROM calc
WHERE
  (is_active = 1 AND (ever_active_before IS NULL OR ever_active_before = 0))
  OR (is_active = 1 AND prev_active = 1)
  OR (is_active = 1 AND prev_active = 0)
  OR (is_active = 0 AND prev_active = 1)
ORDER BY advertiser_id, month;
