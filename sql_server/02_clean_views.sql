

--creating clean views

CREATE VIEW vw_orders_clean AS
SELECT *
FROM orders
WHERE order_status = 'delivered';

-- aggregating payments first

CREATE VIEW vw_payments_agg AS
SELECT 
    order_id,
    SUM(payment_value) AS total_payment_value
FROM payments
GROUP BY order_id;

-- creatin item level revenue

CREATE VIEW vw_order_items_calc AS
SELECT
    order_id,
    product_id,
    seller_id,
    price,
    freight_value,
    price + freight_value AS item_revenue
FROM order_items;

-- creating view for delivery metrics(ops insight)

CREATE VIEW vw_delivery_metrics AS
SELECT
    order_id,
    DATEDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    ) AS delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

 

