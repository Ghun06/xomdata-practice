-- Xom Data · Retention rate by signup-month cohort
-- Problem: https://xomdata.com/practice/hard-cohort-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
SELECT
    strftime('%Y-%m', s.signup_date) AS signup_month,
    strftime('%Y-%m', a.active_date) AS active_month,
    COUNT(DISTINCT s.user_id) AS n_active
FROM signups s
JOIN activity a
    ON s.user_id = a.user_id
WHERE strftime('%Y-%m', a.active_date) >= strftime('%Y-%m', s.signup_date)
GROUP BY
    strftime('%Y-%m', s.signup_date),
    strftime('%Y-%m', a.active_date)
ORDER BY
    signup_month ASC,
    active_month ASC;
