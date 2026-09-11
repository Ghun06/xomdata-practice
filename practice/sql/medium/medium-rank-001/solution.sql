-- Xom Data · Grand final leaderboard
-- Problem: https://xomdata.com/practice/medium-rank-001
-- Solved: 2026-09-11

-- Write your SQL here
SELECT RANK() OVER(ORDER BY points DESC) AS final_rank,
        player_name, points
FROM players
ORDER BY points DESC, player_name asc;
