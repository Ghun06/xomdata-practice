-- Xom Data · Price tiers for rooms on sale
-- Problem: https://xomdata.com/practice/medium-denserank-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
SELECT
    room_no,
    price,
    DENSE_RANK() OVER (ORDER BY price DESC) AS price_tier
FROM rooms
ORDER BY price_tier ASC, room_no ASC;
