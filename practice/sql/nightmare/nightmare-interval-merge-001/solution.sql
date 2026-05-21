-- Xom Data · Merge overlapping bookings into continuous ranges
-- Problem: https://xomdata.com/practice/nightmare-interval-merge-001
-- Solved: 2026-05-21

-- Viết SQL của bạn ở đây
WITH
ordered AS (
    SELECT
        id,
        room_id,
        start_at,
        end_at,
        MAX(end_at) OVER (
            PARTITION BY room_id
            ORDER BY start_at, end_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS max_end_before
    FROM bookings
),

flagged AS (
    SELECT
        *,
        CASE
            WHEN max_end_before IS NULL        THEN 1  
            WHEN start_at > max_end_before     THEN 1  
            ELSE                                    0
        END AS new_group_flag
    FROM ordered
),

grouped AS (
    SELECT
        *,
        SUM(new_group_flag) OVER (
            PARTITION BY room_id
            ORDER BY start_at, end_at
            ROWS UNBOUNDED PRECEDING
        ) AS group_id
    FROM flagged
)

SELECT
    room_id,
    MIN(start_at)  AS merged_start,
    MAX(end_at)    AS merged_end,
    COUNT(*)       AS n_bookings,
    (strftime('%s', MAX(end_at)) - strftime('%s', MIN(start_at))) / 60 AS duration_min
FROM grouped
GROUP BY room_id, group_id
ORDER BY room_id, merged_start;
