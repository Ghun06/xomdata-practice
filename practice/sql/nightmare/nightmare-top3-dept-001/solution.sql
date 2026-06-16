-- Xom Data · Top 3 salaries per department
-- Problem: https://xomdata.com/practice/nightmare-top3-dept-001
-- Solved: 2026-06-16

-- Viết SQL của bạn ở đây
SELECT Department, Employee, salary
FROM (
SELECT 
    Department.name as Department, Employee.name as Employee, salary,
    DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS rnk
FROM Employee JOIN Department ON Employee.departmentId = Department.id
) tb
WHERE rnk <= 3
ORDER BY Department ASC, Salary DESC, Employee;
