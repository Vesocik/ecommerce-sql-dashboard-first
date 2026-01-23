-- Setting up a search path
SET search_path TO "Online-Shop-2024";

-- Query 1: A list of products with the amount of sold items and summarized income.
SELECT 
    p.product_name AS Product_Name,
    SUM(oi.quantity) AS Amount_of_Sold_Items,
    ROUND(
        SUM(oi.quantity * p.price)::numeric, 2
    ) AS Total_Income
FROM
    products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY 
    p.product_name
ORDER BY
    total_income DESC

-- Query 2: Average and Maximum order value per customer
SELECT
    CONCAT(c.first_name,' ',c.last_name) AS Customer_Name,
    ROUND(
        AVG(o.total_price)::numeric, 2)
    AS Average_order_value,
    MAX(o.total_price) AS Maximum_order_value
FROM
    customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    Customer_Name

-- Query 3: Delayed orders (comparing order date and shipping date). I have modified it a little bit, creating CTE and checking for Delayed and On Time deliveries.
WITH shipment_status AS (
    SELECT
        o.order_id AS Order_ID,
        o.order_date AS Order_Date,
        s.shipment_date AS Shipment_date,
        CASE
            WHEN o.order_date = s.shipment_date
            THEN 'On Time'
            ELSE 'Delayed'
        END AS Shipment
    FROM 
        orders o
    LEFT JOIN shipments s
        ON o.order_id = s.order_id
)
SELECT
    *
FROM
    shipment_status
WHERE
    Shipment = 'Delayed'

/* Query 4: Best selling products within last month. As the database is based on year 2024, I have extracted 2 years and 1 month from the order_date.
I have created best_product table to gather product name and a total income, and added order_id to join best_product and orders table */
WITH best_product AS (
    SELECT
        oi.order_id,
        p.product_name AS Product_name,
        sum(p.price * oi.quantity) AS Total_Income
    FROM 
        products p
    JOIN order_items oi
        ON p.product_id = oi.product_id 
    GROUP BY
        p.product_name, oi.order_id
)
SELECT
    bp.product_name,
    o.order_date,
    bp.total_income,
    rank() OVER (ORDER BY bp.total_income DESC) AS Product_Rank
FROM
    best_product bp
JOIN orders o
    ON bp.order_id = o.order_id
WHERE
    o.order_date >= date_trunc('month', CURRENT_DATE - INTERVAL '2 year 1 month')
    AND o.order_date < date_trunc('month', CURRENT_DATE - INTERVAL '2 year')
