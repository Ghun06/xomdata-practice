-- Xom Data · Median from a frequency distribution
-- Problem: https://xomdata.com/practice/nightmare-median-freq-001
-- Solved: 2026-11-19

WITH cum AS (
    SELECT
        number,
        frequency,
        SUM(frequency) OVER (ORDER BY number) AS cum_freq,
        SUM(frequency) OVER ()                AS total
    FROM Numbers
    WHERE frequency > 0
)
SELECT
    AVG(number * 1.0) AS median
FROM cum
WHERE cum_freq - frequency < CEIL((total + 1) / 2.0)   -- vị trí bắt đầu của dòng <= vị trí cần tìm
  AND cum_freq >= FLOOR((total + 1) / 2.0);            -- vị trí kết thúc của dòng >= vị trí cần tìm
