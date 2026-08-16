-- Xom Data · Most common 3-step user path
-- Problem: https://xomdata.com/practice/hard-pathanalysis-001
-- Solved: 2026-08-16

WITH ordered AS (
    SELECT
        user_id,
        page,
        viewed_at,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY viewed_at) AS rn
    FROM page_views
),
triples AS (
    SELECT
        o1.user_id,
        o1.page || ' > ' || o2.page || ' > ' || o3.page AS path
    FROM ordered o1
    JOIN ordered o2
        ON o2.user_id = o1.user_id AND o2.rn = o1.rn + 1
    JOIN ordered o3
        ON o3.user_id = o1.user_id AND o3.rn = o1.rn + 2
)
SELECT
    path,
    COUNT(DISTINCT user_id) AS n_users
FROM triples
GROUP BY path
ORDER BY n_users DESC, path ASC
LIMIT 10;
