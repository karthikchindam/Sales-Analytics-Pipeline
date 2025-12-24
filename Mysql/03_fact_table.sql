

/* Creating a fact table*/

DROP TABLE IF EXISTS fact_sales_report;


CREATE TABLE fact_sales_report AS
SELECT
  o.order_id,
  oi.product_id,
  p.product_category_name,
  c.customer_id,
  c.customer_state,
  oi.seller_id,

  o.order_purchase_timestamp,
  o.order_month,

  oi.price,
  oi.freight_value,
  oi.item_revenue,

  pm.total_payment_value,
  dm.delivery_days,
  r.review_score

FROM vw_orders_clean o
LEFT JOIN vw_order_items_calc oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN vw_payments_agg pm ON o.order_id = pm.order_id
LEFT JOIN vw_delivery_metrics dm ON o.order_id = dm.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id;
