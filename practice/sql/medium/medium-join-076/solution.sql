-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-05-25

-- Viết SQL của bạn ở đây
WITH factb AS (
SELECT movie_name, genres, COUNT(*) AS showtime_count, ROUND(AVG(ticket_price), 0) AS avg_ticket_price
FROM movies
JOIN showtimes ON movies.id = showtimes.movie_id
GROUP BY movie_name, genres
HAVING COUNT(*) >= 1
)
SELECT
    movie_name,
    genres,
    showtime_count,
    avg_ticket_price,
    DENSE_RANK()  OVER (PARTITION BY genres ORDER BY avg_ticket_price DESC) AS rank_in_genre,
    FIRST_VALUE(movie_name) OVER (PARTITION BY genres ORDER BY avg_ticket_price DESC) AS top_movie_in_genre
FROM factb
ORDER BY genres, rank_in_genre;
