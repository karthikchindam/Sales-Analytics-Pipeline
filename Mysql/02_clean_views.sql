


/* creating clean views*/

DROP VIEW IF EXISTS vw_orders_clean;

CREATE VIEW vw_orders_clean AS
SELECT
  order_id,
  customer_id,

  STR_TO_DATE(NULLIF(order_purchase_timestamp, ''), '%d-%m-%Y %H:%i')
    AS order_purchase_timestamp,

  DATE_FORMAT(
    STR_TO_DATE(NULLIF(order_purchase_timestamp, ''), '%d-%m-%Y %H:%i'),
    '%Y-%m'
  ) AS order_month

FROM orders
WHERE order_status = 'delivered'
  AND order_purchase_timestamp <> '';



CREATE OR REPLACE VIEW vw_order_items_calc AS
SELECT
  order_id,
  product_id,
  seller_id,
  price,
  freight_value,
  (price + freight_value) AS item_revenue
FROM order_items;


CREATE OR REPLACE VIEW vw_payments_agg AS
SELECT
  order_id,
  SUM(payment_value) AS total_payment_value
FROM payments
GROUP BY order_id;


DROP VIEW IF EXISTS vw_delivery_metrics;

CREATE VIEW vw_delivery_metrics AS
SELECT
  order_id,
  DATEDIFF(
    STR_TO_DATE(NULLIF(order_delivered_customer_date, ''), '%d-%m-%Y %H:%i'),
    STR_TO_DATE(NULLIF(order_estimated_delivery_date, ''), '%d-%m-%Y %H:%i')
  ) AS delivery_days
FROM orders
WHERE order_delivered_customer_date <> ''
  AND order_estimated_delivery_date <> '';


