-- Xom Data · TWAP per stock symbol
-- Problem: https://xomdata.com/practice/sql-nightmare-010
-- Solved: 2026-11-19

WITH ticks AS (
    SELECT
        symbol,
        price,
        tick_time::timestamp AS t,
        LEAD(tick_time::timestamp) OVER (
            PARTITION BY symbol
            ORDER BY tick_time::timestamp
        ) AS next_t
    FROM price_ticks
)
SELECT
    symbol,
    ROUND(
        (SUM(price * EXTRACT(EPOCH FROM (next_t - t)))
         / SUM(EXTRACT(EPOCH FROM (next_t - t))))::numeric,
        4
    ) AS twap
FROM ticks
WHERE next_t IS NOT NULL   -- bỏ lần báo giá cuối của mỗi mã
GROUP BY symbol
ORDER BY symbol;
