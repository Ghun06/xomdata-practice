-- Xom Data · Median salary per department
-- Problem: https://xomdata.com/practice/sql-nightmare-002
-- Solved: 2026-06-08

-- Viết query của bạn ở đây
WITH rnk_in_salary AS (
    SELECT
        dept,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY dept
            ORDER BY salary
        ) AS rnk,
        COUNT(*) OVER (
            PARTITION BY dept
        ) AS cnt
    FROM employees
)
SELECT
    dept,
    AVG(salary * 1.0) AS median_salary
FROM rnk_in_salary
WHERE rnk IN (
    (cnt + 1) / 2,
    (cnt + 2) / 2
)
GROUP BY dept
ORDER BY dept;
