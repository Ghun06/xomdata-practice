-- Xom Data · Opening order or returning order
-- Problem: https://xomdata.com/practice/medium-cohort-002
-- Solved: 2026-08-28

-- Viết SQL của bạn ở đây
SELECT customer_name, order_date, amount,
    CASE 
        WHEN order_date = MIN(order_date) OVER(PARTITION BY customer_name)
        THEN 'New'
        ELSE 'Returning'
    END AS order_type
FROM orders
ORDER BY customer_name, order_date ASC;
