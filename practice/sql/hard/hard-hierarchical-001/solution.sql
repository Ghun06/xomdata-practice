-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-08-17

-- Viết SQL của bạn ở đây
WITH RECURSIVE descendants AS (
    SELECT
        id AS root_id,
        id AS member_id
    FROM agents
    UNION ALL
    SELECT
        d.root_id,
        a.id AS member_id
    FROM descendants d
    JOIN agents a ON a.manager_id = d.member_id
)
SELECT
    a.id AS agent_id,
    a.name AS agent_name,
    a.direct_sales,
    SUM(a2.direct_sales) AS team_total
FROM descendants d
JOIN agents a ON a.id = d.root_id
JOIN agents a2 ON a2.id = d.member_id
GROUP BY a.id, a.name, a.direct_sales
ORDER BY team_total DESC, agent_id ASC;
