-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-06-02

-- Viết SQL của bạn ở đây
WITH avg_stu AS (
SELECT full_name, student_code, ROUND(avg(final_score), 2) AS avg_score
FROM students
JOIN scores ON students.id = scores.student_id
GROUP BY student_code
)
SELECT * FROM (
SELECT *, 
       CASE WHEN avg_score >= 9 THEN 'Excellent'
       WHEN avg_score >= 8 THEN 'Good'
       WHEN avg_score >= 7 THEN 'Fair'
       WHEN avg_score >= 5 THEN 'Average'
       ELSE 'Poor' END AS grade,
       DENSE_RANK() OVER(ORDER BY avg_score DESC) AS class_rank
FROM avg_stu
)
WHERE class_rank <= 20;
