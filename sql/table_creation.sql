-- Create the sales_orders table
CREATE TABLE sales_orders (
    order_id       NUMBER PRIMARY KEY,
    customer_name  VARCHAR2(100),
    region         VARCHAR2(50),
    product_name   VARCHAR2(100),
    quantity       NUMBER,
    unit_price     NUMBER,
    total_amount   NUMBER,
    order_date     DATE
);
