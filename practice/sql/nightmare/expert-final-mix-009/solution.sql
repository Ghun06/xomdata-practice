-- Xom Data · Three-level sales totals: detail, by region, company-wide
-- Problem: https://xomdata.com/practice/expert-final-mix-009
-- Solved: 2026-06-18

-- Viết query của bạn ở đây
WITH all_total AS (
    SELECT 
        region, 
        room, 
        SUM(revenue) AS total_sales,
        0 AS group_level -- Dùng để hỗ trợ sắp xếp
    FROM sales
    GROUP BY region, room
    UNION ALL
    SELECT 
        region, 
        NULL AS room, 
        SUM(revenue) AS total_sales,
        1 AS group_level
    FROM sales
    GROUP BY region
    UNION ALL
    SELECT 
        NULL AS region, 
        NULL AS room, 
        SUM(revenue) AS total_sales,
        2 AS group_level
    FROM sales
)
SELECT region, room, total_sales
FROM all_total
ORDER BY 
    CASE WHEN region IS NULL THEN 1 ELSE 0 END, 
    region ASC,

    CASE WHEN room IS NULL THEN 1 ELSE 0 END, 
    room ASC;
