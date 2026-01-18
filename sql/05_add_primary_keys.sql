-- Adding primary keys to tables in the "Online-Shop-2024" schema
Alter table "Online-Shop-2024".order_items
    Add Primary KEY (order_item_id);

Alter TABLE "Online-Shop-2024".orders
    ADD PRIMARY KEY (order_id);

ALTER TABLE "Online-Shop-2024".payment
    ADD PRIMARY KEY (payment_id);

ALTER TABLE "Online-Shop-2024".products
    ADD PRIMARY KEY (product_id);

ALTER TABLE "Online-Shop-2024".reviews
    ADD PRIMARY KEY (review_id);

ALTER TABLE "Online-Shop-2024".shipments
    ADD PRIMARY KEY (shipment_id);

ALTER TABLE "Online-Shop-2024".suppliers
    ADD PRIMARY KEY (supplier_id);