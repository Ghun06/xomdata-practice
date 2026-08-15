-- Xom Data · Time-weighted average price
-- Problem: https://xomdata.com/practice/nightmare-twa-001
-- Solved: 2026-08-15

SELECT
    ticker,
    ROUND(SUM(price * days) / SUM(days), 4) AS twa
FROM (
    SELECT
        ticker,
        price,
        julianday(LEAD(valid_from) OVER (PARTITION BY ticker ORDER BY valid_from))
            - julianday(valid_from) AS days
    FROM price_states
)
WHERE days IS NOT NULL
GROUP BY ticker
ORDER BY ticker;
