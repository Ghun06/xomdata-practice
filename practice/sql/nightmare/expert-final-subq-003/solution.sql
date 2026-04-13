-- Xom Data · Second-highest-paid employee per department
-- Problem: https://xomdata.com/practice/expert-final-subq-003
-- Solved: 2026-04-13

-- Viết query của bạn ở đây
SELECT departments, full_name, salaries
FROM (
    SELECT departments, full_name, salaries,
    DENSE_RANK() OVER (PARTITION BY departments ORDER BY salaries DESC) as rnk
    FROM employees
) t
WHERE rnk = 2
ORDER BY departments, full_name
