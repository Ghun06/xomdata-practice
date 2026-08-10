-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-08-10

SELECT
  phone_number,
  full_name,
  plans
FROM
  subscribers
WHERE
  LOWER(plans) LIKE '%basic%'
ORDER BY
  full_name ASC;
