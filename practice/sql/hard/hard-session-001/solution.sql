-- Xom Data · Sessionize logins with a 30-minute gap
-- Problem: https://xomdata.com/practice/hard-session-001
-- Solved: 2026-05-22

-- Viết SQL của bạn ở đây
WITH
lagge_table AS (
    SELECT id, user_id, event_at, LAG(event_at) OVER (PARTITION BY user_id ORDER BY event_at) AS prev_event
    FROM events
),

flag AS (
    SELECT *,
        CASE 
            WHEN prev_event IS NULL THEN 1
            WHEN (JULIANDAY(event_at) - JULIANDAY(prev_event))
                 * 1440 > 30 THEN 1
            ELSE 0
            END AS new_session_flag
    FROM lagge_table
),
sessionized AS (
    SELECT
        *,
        SUM(new_session_flag) OVER (
            PARTITION BY user_id
            ORDER BY event_at
            ROWS UNBOUNDED PRECEDING
        ) AS session_seq
    FROM flag
)

SELECT
    user_id,
    session_seq,
    COUNT(*)  AS n_events,
    MIN(event_at) AS session_start,
    MAX(event_at) AS session_end,
    ROUND(
        (JULIANDAY(MAX(event_at)) - JULIANDAY(MIN(event_at))) * 1440
    , 1)                                                    AS duration_min
FROM sessionized
GROUP BY user_id, session_seq
ORDER BY user_id, session_seq;
