-- Xom Data · Longest rising price run over N trading sessions
-- Problem: https://xomdata.com/practice/nightmare-lis-001
-- Solved: 2026-11-17

WITH RECURSIVE seq AS (
    SELECT
        day    AS last_day,
        price  AS last_price,
        1      AS len,
        price::text AS path
    FROM prices

    UNION ALL

    SELECT
        p.day,
        p.price,
        s.len + 1,
        s.path || ',' || p.price::text
    FROM seq s
    JOIN prices p
      ON p.day   > s.last_day
     AND p.price > s.last_price
)
SELECT
    len  AS lis_length,
    path AS lis_sequence
FROM seq
ORDER BY len DESC, path COLLATE "C" ASC
LIMIT 1;
