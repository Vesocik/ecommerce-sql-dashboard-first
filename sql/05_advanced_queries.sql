SET search_path TO "Online-Shop-2024";

-- Query 1: RFM Analysis. December 2023 taken for analysis
SELECT
    Customer_Name,
    MAX(order_date) AS Recency, --Date of the most recent purchase
    COUNT(order_id) AS Frequency, -- Count how many orders each customer made
    SUM(total_price) AS Monetary -- Sum of total spend 
FROM ( -- Subquery to select a date range
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

-- Query 2: Suppliers rank based on delivery amount and average delivery time
SELECT
    RANK() OVER (ORDER BY COUNT(sh.shipment_id) DESC) AS Rank, -- Rank of the suppliers, ordered by total delivery amount
    s.supplier_name AS Supplier_name,
    COUNT(sh.shipment_id) AS Total_delivery_amount, -- Total Delivery Amount
    AVG(sh.delivery_date - sh.shipment_date) AS Average_delivery_time -- Average delivery time
FROM
    suppliers s
JOIN products p -- Multiple joins based on ERD Diagram and built relations. 
    ON s.supplier_id = p.supplier_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
JOIN shipments sh
    ON o.order_id = sh.order_id
GROUP BY
    s.supplier_name

-- Query 3: Worst review products with the biggest income
WITH product_stats AS (
    SELECT
        p.product_name AS product_name,
        r.rating AS rating,
        SUM(oi.quantity * p.price) AS total_income
    FROM
        products p
    JOIN reviews r
        ON p.product_id = r.product_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name, r.rating
)
SELECT
    product_name,
    rating,
    total_income
FROM 
    product_stats
ORDER BY 
    rating ASC, total_income DESC

-- Query 4: Monthyl/quarterly sales trend
-- CTE to create a table with months and aggregated sales
WITH month_income AS ( 
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(total_price) AS sales
    FROM
        orders
    GROUP BY
        1
    ORDER BY
        1
) 
SELECT
    month,
    sales,
    sales - LAG(sales) OVER (ORDER BY month) AS sales_diff, 
    -- Calculate the difference between current and previous month.
    (sales - LAG(sales) OVER(ORDER BY month)) / NULLIF(LAG(sales) OVER(ORDER BY month), 0) *100 AS sales_trend
    -- Calculate a sales trend in percentage. NULLIF to not divide by 0
FROM
    month_income
ORDER BY
    month

-- Query 5: Number of orders per customer each month with a ranking of top customers.
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, -- Connecting First name with last name
    COUNT(o.order_id) AS no_of_orders,
    DATE_TRUNC('month', o.order_date)::date AS month, -- Counting the months
    DENSE_RANK() OVER (PARTITION BY DATE_TRUNC('month', o.order_date)::date ORDER BY COUNT(o.order_id) DESC) AS rank 
    -- PARTITION BY month is required to list top customers each month separately.
FROM
    customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    month, customer_name
ORDER BY
    month, rank