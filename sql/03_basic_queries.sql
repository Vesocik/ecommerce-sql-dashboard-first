--Setting up a search path
SET search_path TO "Online-Shop-2024";

--Query 1: Showing all clients with their contact details. 
SELECT * 
FROM customers

/*Query 2: Showing all orders with data and a value (summary with Order_Items). 
Value is a sum of quantity multiply by an average price_at_purchase (as these varies between dates, I decided to make an average).
Here I am trying to start using short aliases for tables references and follow the code building norm */
SELECT
    o.order_id AS Order_Number,
    o.order_date AS Order_Date,
    SUM(oi.quantity) * AVG(oi.price_at_purchase) AS Order_Value
FROM 
    orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id, o.order_date

/* Query 3: All products within a specified price range. 
I used SELECT MIN and SELECT MAX to check the price range, and then randomly choose a price range - from 327.48 to 614.03.
SELECT
    MIN(price),
    MAX(price)
FROM
    products */
SELECT
    *
FROM
    products
WHERE price BETWEEN 327.48 AND 614.03

--Query 4: Show the review for a specific product. I randomly selected product with product_id = 50
SELECT
    *
FROM reviews
WHERE product_id = 50
