-- Xom Data · Users active 5+ consecutive days
-- Problem: https://xomdata.com/practice/nightmare-active-users-001
-- Solved: 2026-05-27

-- Viết SQL của bạn ở đây
WITH deduplicated AS (
    SELECT DISTINCT
        id,
        login_date
    FROM Logins
),
ranked AS (
    SELECT
        id,
        login_date,
        ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY login_date
        ) AS rn
    FROM deduplicated
),
islands AS (
    SELECT
        id,
        DATE(login_date, '-' || (rn - 1) || ' days') AS island_key,
        COUNT(*) AS streak_len
    FROM ranked
    GROUP BY id, island_key
)
SELECT DISTINCT id
FROM islands
WHERE streak_len >= 5
ORDER BY id;
