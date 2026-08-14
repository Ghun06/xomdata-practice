-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-08-14

-- Summarize buy/sell totals per investor
WITH factb as (
    SELECT
      full_name,
      segment,
      COUNT(*) AS total_trades,
      COALESCE(SUM(CASE WHEN side = 'buy' THEN amount END), 0) AS total_bought,
      COALESCE(SUM(CASE WHEN side = 'sell' THEN amount END), 0) AS total_sold
    FROM investors i
    JOIN trades t ON t.investor_id = i.id
    GROUP BY i.id
)
SELECT factb.*,
       total_bought - total_sold AS net_position,
       CASE 
          WHEN total_bought > total_sold THEN 'Bull'
          WHEN total_bought = total_sold THEN 'Neutral'
          ELSE 'Bear'
       END AS stance,
       DENSE_RANK() OVER (PARTITION BY segment ORDER BY total_bought + total_sold DESC) AS rank_in_segment
FROM factb
ORDER BY total_bought + total_sold DESC, full_name ASC;
