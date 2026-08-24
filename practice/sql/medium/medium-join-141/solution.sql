-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-08-24

WITH doctor_stats AS (
    SELECT f.faculty_name, d.full_name AS doctor_name,
        COUNT(mv.id) AS visit_count,
        AVG(mv.visit_fee) AS avg_exam_fee,
        SUM(mv.visit_fee) AS total_exam_fee
    FROM doctors d
    JOIN faculties f ON d.faculty_id = f.id
    JOIN medical_visits mv ON d.id = mv.doctor_id
    GROUP BY f.faculty_name, d.id, d.full_name
)
    SELECT *,
        RANK() OVER (ORDER BY total_exam_fee DESC) AS overall_rank,
        DENSE_RANK() OVER (PARTITION BY faculty_name ORDER BY total_exam_fee DESC) AS rank_in_faculty
    FROM doctor_stats
    ORDER BY
    total_exam_fee DESC,
    doctor_name ASC
    LIMIT 15
