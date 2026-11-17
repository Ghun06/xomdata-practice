-- Xom Data · Cumulative revenue and cumulative % of the period total
-- Problem: https://xomdata.com/practice/expert-final-win-008
-- Solved: 2026-11-17

SELECT
    period,
    SUM(revenue)                                   AS period_revenue,
    SUM(SUM(revenue)) OVER (ORDER BY period)       AS running_total,
    SUM(SUM(revenue)) OVER ()                      AS grand_total,
    ROUND(
        SUM(SUM(revenue)) OVER (ORDER BY period) * 100.0
        / SUM(SUM(revenue)) OVER (),
        1
    )                                              AS cumulative_pct
FROM sales
GROUP BY period
ORDER BY period;
