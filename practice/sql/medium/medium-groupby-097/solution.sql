-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-08-30

WITH post_stats AS (
    SELECT
        u.full_name,
        p.id,
        p.post_type,
        p.post_date,
        p.like_count
            + p.comment_count
            + p.share_count AS total_interactions
    FROM posts p
    JOIN users u
        ON p.user_id = u.id
),

ranked_posts AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_interactions DESC
        ) AS overall_rank,

        ROW_NUMBER() OVER (
            PARTITION BY full_name
            ORDER BY total_interactions DESC, post_date ASC
        ) AS rank_in_author,

        MAX(total_interactions) OVER () AS top_interactions
    FROM post_stats
)

SELECT
    full_name,
    post_type,
    post_date,
    total_interactions,
    overall_rank,
    rank_in_author,
    ROUND(
        total_interactions * 100.0 / top_interactions,
        2
    ) AS pct_of_top
FROM ranked_posts
WHERE overall_rank <= 10
ORDER BY
    overall_rank ASC,
    full_name ASC,
    rank_in_author ASC;
