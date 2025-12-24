
--creating production database

-- importing the raw data in test environment

create database olist_prod
use olist_prod

-- data ingestion

select count(*) from [dbo].[orders]
select count(*) from [dbo].[order_items]
select count(*) from [dbo].[customers]
select count(*) from [dbo].[products]
select count(*) from [dbo].[payments]
select count(*) from [dbo].[reviews]
select count(*) from [dbo].[sellers]
select count (*) from [dbo].[geolocation]

select top 10 * from orders

--data understanding and quality checks

select count(*) as total_orders from orders
select count(distinct order_id) from orders   -- two numbers are same


select count(*) from [dbo].[order_items]
select count(distinct order_id) from [dbo].[order_items] --confirms 1 order-> many items


--key validation

--orders<->customers
select count(*) from orders o
left join customers c
on o.customer_id = c.customer_id
where c.customer_id is null         --o/p = 0 indicates no null values

--orders<->Order items
select count(*) from orders o
left join order_items oi
on o.order_id = oi.order_id
where oi.order_id is null          -- these are ~775 orders with no items

--order status check
select order_status, count(*) from orders
group by order_status
order by count(*) desc         --delivered,shipped,canceled,unavailable,invoiced,processing,created,approved
                          -- delivered not equals purchased and canceled not equals revenue

--payment table check                      
select order_id, count(*) from payments
group by order_id
having count(*) > 1
/*
This proves:
One order can have multiple payments
Summing payment_value blindly = wrong revenue
*/


-- revenue columns(finding source)
select
min(price), max(price),
min(freight_value), max(freight_value)
from order_items
/*
Revenue not equal to payment_value always
Revenue is price + freight_value (business decision)
*/

--delivery and review relationship
select count(*) from reviews r
left join orders o
on r.order_id=o.order_id
where o.order_id is null

select count(*) from orders
where order_delivered_customer_date is null    --not error it means order not delivered or cancelled


-- date range and business period check
select 
max(order_purchase_timestamp),
min(order_purchase_timestamp)
from orders                     

 

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



 
--creating a fact table for final reporting

SELECT
    o.order_id,
    oi.product_id,
    p.product_category_name,
    c.customer_id,
    c.customer_state,
    oi.seller_id,

    o.order_purchase_timestamp,
    DATENAME(MONTH, o.order_purchase_timestamp) AS order_month,

    oi.price,
    oi.freight_value,
    oi.item_revenue,

    pm.total_payment_value,
    dm.delivery_days,
    r.review_score

INTO fact_sales_report

FROM vw_orders_clean o

LEFT JOIN vw_order_items_calc oi
    ON o.order_id = oi.order_id

LEFT JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN customers c
    ON o.customer_id = c.customer_id

LEFT JOIN vw_payments_agg pm
    ON o.order_id = pm.order_id

LEFT JOIN vw_delivery_metrics dm
    ON o.order_id = dm.order_id

LEFT JOIN reviews r
    ON o.order_id = r.order_id;


select top 10 * from fact_sales_report


 

 



