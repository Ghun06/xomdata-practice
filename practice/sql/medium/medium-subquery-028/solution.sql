-- Xom Data · Students above the subject average
-- Problem: https://xomdata.com/practice/medium-subquery-028
-- Solved: 2026-05-28

-- Viết SQL của bạn ở đây
WITH tbmon AS (
    SELECT subject_id, ROUND(AVG(final_score), 2) AS subject_avg
    FROM grades
    GROUP BY subject_id
)
SELECT full_name, 
       dish_name, 
       final_score, 
       subject_avg, 
       (final_score - subject_avg) AS diff_from_avg
FROM grades gs
JOIN students ON gs.student_id = students.id
JOIN subjects ON gs.subject_id = subjects.id
JOIN tbmon ON gs.subject_id = tbmon.subject_id
WHERE final_score > subject_avg
ORDER BY diff_from_avg DESC, dish_name, full_name
