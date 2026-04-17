-- Xom Data · Top 2 salespeople by sales each month
-- Problem: https://xomdata.com/practice/expert-final-multi-007
-- Solved: 2026-04-17

WITH factb AS (
    SELECT 
        month,
        employee_id,
        SUM(revenue) AS total_sales
    FROM sales
    GROUP BY month, employee_id
),
ranked AS (
    SELECT 
        f.month,
        DENSE_RANK() OVER (
            PARTITION BY f.month 
            ORDER BY f.total_sales DESC
        ) AS hang,
        f.employee_id,
        e.full_name,
        f.total_sales
    FROM factb f
    JOIN employees e 
        ON f.employee_id = e.id
)
SELECT *
FROM ranked
WHERE hang <= 2
ORDER BY month, hang;
