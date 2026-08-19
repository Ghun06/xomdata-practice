-- Xom Data · Raw material cost of finished goods (multi-level BoM)
-- Problem: https://xomdata.com/practice/expert-final-rec-003
-- Solved: 2026-08-19

WITH RECURSIVE bom AS (
    SELECT
        product_id  AS root_id,      
        material_id AS material_id,  
        quantity    AS cum_qty       
    FROM ingredients
    WHERE product_id IN (
        SELECT id FROM products
        WHERE id NOT IN (SELECT material_id FROM ingredients)
    )

    UNION ALL
    SELECT
        b.root_id,
        i.material_id,
        b.cum_qty * i.quantity
    FROM bom b
    JOIN ingredients i ON i.product_id = b.material_id
)
SELECT
    b.root_id                          AS product_id,
    p.name                             AS name,
    SUM(b.cum_qty * mp.selling_price)  AS total_cost
FROM bom b
JOIN products p  ON p.id = b.root_id
JOIN products mp ON mp.id = b.material_id
WHERE b.material_id NOT IN (SELECT product_id FROM ingredients) 
GROUP BY b.root_id, p.name
ORDER BY b.root_id;
