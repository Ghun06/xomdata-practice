-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-07-24

WITH factb AS (
SELECT vehicle_type, capacity_tons, COUNT(shipments.id) AS shipment_count,
    CASE 
        WHEN capacity_tons >= 10 THEN "Large Truck"
        WHEN capacity_tons >= 5 THEN "Medium Truck"
        ELSE "Small Truck"
    END AS size_class,
    COUNT(CASE WHEN results = 'success' THEN 1 END) AS delivered
FROM trucks
JOIN shipments ON trucks.id = shipments.truck_id
JOIN deliveries ON deliveries.shipment_id = shipments.id
GROUP BY vehicle_type
)
SELECT *,
    ROUND(delivered*100.0/shipment_count, 2) AS delivery_rate,
    RANK() OVER(PARTITION BY size_class ORDER BY ROUND(delivered*100.0/shipment_count, 2) DESC) AS rank_in_size
FROM factb
ORDER BY size_class, rank_in_size, vehicle_type;
