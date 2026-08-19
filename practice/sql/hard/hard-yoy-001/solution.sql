-- Xom Data · YoY and QoQ sales growth
-- Problem: https://xomdata.com/practice/hard-yoy-001
-- Solved: 2026-08-19

-- Viết SQL của bạn ở đây
WITH lagged AS (
    SELECT
        year,
        quarter,
        revenue,
        LAG(revenue, 1) OVER (ORDER BY year, quarter) AS prev_quarter_revenue,
        LAG(revenue, 4) OVER (ORDER BY year, quarter) AS prev_year_revenue
    FROM quarterly_sales
)
SELECT
    year,
    quarter,
    revenue,
    prev_quarter_revenue,
    prev_year_revenue,
    CASE
        WHEN prev_quarter_revenue IS NULL OR prev_quarter_revenue = 0 THEN NULL
        ELSE ROUND((revenue - prev_quarter_revenue) * 100.0 / prev_quarter_revenue, 2)
    END AS qoq_pct,
    CASE
        WHEN prev_year_revenue IS NULL OR prev_year_revenue = 0 THEN NULL
        ELSE ROUND((revenue - prev_year_revenue) * 100.0 / prev_year_revenue, 2)
    END AS yoy_pct
FROM lagged
ORDER BY year, quarter;
