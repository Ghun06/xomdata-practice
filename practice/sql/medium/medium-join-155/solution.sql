-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-08-06

SELECT hotel_name, star_class, destination_name,
    COUNT(*) AS room_count,
    MIN(nightly_rate) AS min_price,
    MAX(nightly_rate) AS max_price,
    ROUND(AVG(nightly_rate),0) AS avg_price, 
    MAX(nightly_rate) - MIN(nightly_rate) AS price_spread,
    DENSE_RANK() OVER(PARTITION BY destination_id ORDER BY AVG(nightly_rate) DESC) AS rank_in_destination
FROM hotels
JOIN destinations ds ON ds.id = hotels.destination_id
JOIN hotel_rooms hs ON hs.hotel_id = hotels.id
GROUP BY hotel_name, star_class, destination_name
HAVING COUNT(*) >= 2
ORDER BY rank_in_destination, destination_name, hotel_name ASC
