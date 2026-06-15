-- Xom Data · Daily trip cancellation rate (unbanned users/drivers only)
-- Problem: https://xomdata.com/practice/nightmare-cancel-rate-001
-- Solved: 2026-06-15

-- Viết SQL của bạn ở đây
SELECT
    t.request_at AS Day,
    ROUND(
        SUM(CASE WHEN t.status LIKE '%cancelled%' THEN 1.0 ELSE 0 END)
        / COUNT(*),
        2
    ) AS Cancellation_Rate
FROM Trips t
JOIN Users c ON t.client_id = c.users_id AND c.banned = 'No'
JOIN Users d ON t.driver_id = d.users_id AND d.banned = 'No'
WHERE t.request_at BETWEEN '2024-01-01' AND '2024-01-03'
GROUP BY t.request_at
ORDER BY t.request_at;
