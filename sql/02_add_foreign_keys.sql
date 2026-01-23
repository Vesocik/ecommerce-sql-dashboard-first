--Setting up a schema search
Set search_path TO "Online-Shop-2024";

--Check for data integrity before setting up foreign key constraints (similar check for every foreign key constraint)
Select customer_id
FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

--Setting up a Foreign Key Constraint

--Orders to Customers on customer_id
Alter table orders
    ADD CONSTRAINT fk_orders_customers
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Reviews to Customers on customer_id
ALTER TABLE reviews
    ADD CONSTRAINT fk_reviews_customers
    FOREIGN KEY (customer_id) REFERENCES "Online-Shop-2024".customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Order_items to Orders on order_id
ALTER TABLE order_items
    ADD CONSTRAINT fk_order_items_orders
    FOREIGN KEY (order_id) REFERENCES "Online-Shop-2024".orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Payment to Orders on order_id
ALTER TABLE payment
    ADD CONSTRAINT fk_payments_orders
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Shipments to Orders on order_id
ALTER TABLE shipments
    ADD CONSTRAINT fk_shipments_orders
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Order_items to Products on product_id
ALTER TABLE order_items
    ADD CONSTRAINT fk_order_items_products
    FOREIGN KEY (product_id) REFERENCES products(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Products to Suppliers on supplier_id
ALTER TABLE products
    ADD CONSTRAINT fk_products_suppliers
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Reviews to Products on product_id
ALTER TABLE reviews
    ADD CONSTRAINT fk_reviews_products
    FOREIGN KEY (product_id) REFERENCES products(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


