
-- importing the raw data in test environment

create database olist_test
use olist_test

-- data ingestion

select count(*) from [dbo].[orders]
select count(*) from [dbo].[order_items]
select count(*) from [dbo].[customers]
select count(*) from [dbo].[products]
select count(*) from [dbo].[payments]
select count(*) from [dbo].[reviews]

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


