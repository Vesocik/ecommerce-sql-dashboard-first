SET search_path TO "Online-Shop-2024";

-- Query 1: RFM Analysis. December 2023 taken for analysis
SELECT
    Customer_Name,
    MAX(order_date) AS Recency, --Date of the most recent purchase
    COUNT(order_id) AS Frequency, -- Count how many orders each customer made
    SUM(total_price) AS Monetary -- Sum of total spend 
FROM (
    SELECT
        CONCAT(c.first_name,' ',c.last_name) AS Customer_Name,
        o.order_date,
        o.order_id,
        o.total_price
    FROM
        customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 years 1 month')
        AND o.order_date < DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 years')
)
GROUP BY Customer_Name
ORDER BY frequency DESC, monetary DESC

