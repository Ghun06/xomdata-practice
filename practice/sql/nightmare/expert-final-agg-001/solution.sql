-- Xom Data · Quarterly sales per employee (2024)
-- Problem: https://xomdata.com/practice/expert-final-agg-001
-- Solved: 2026-04-24

-- Viết query của bạn ở đây
SELECT employee_id,
       SUM(CASE WHEN quy=1 THEN revenue ELSE 0 END) AS Q1,
       SUM(CASE WHEN quy=2 THEN revenue ELSE 0 END) AS Q2,
       SUM(CASE WHEN quy=3 THEN revenue ELSE 0 END) AS Q3,
       SUM(CASE WHEN quy=4 THEN revenue ELSE 0 END) AS Q4
FROM sales
WHERE year = '2024'
GROUP BY employee_id
