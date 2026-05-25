-- Xom Data · Next session with a higher price
-- Problem: https://xomdata.com/practice/nightmare-nextgreater-001
-- Solved: 2026-05-25

-- Viết SQL của bạn ở đây
SELECT
    p.day,
    p.price,
    MIN(qnd.day)              AS next_higher_day,
    MIN(qnd.day) - p.day      AS days_until
FROM prices p
LEFT JOIN prices qnd
    ON qnd.day   > p.day     
    AND qnd.price > p.price  
GROUP BY p.day, p.price
ORDER BY p.day;
