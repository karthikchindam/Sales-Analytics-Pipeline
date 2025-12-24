

--fact sales data validation checks

-- Row count
SELECT COUNT(*) FROM fact_sales_report;

-- Distinct orders
SELECT COUNT(DISTINCT order_id) FROM fact_sales_report;

-- Revenue check
SELECT SUM(item_revenue) FROM fact_sales_report;



--fact vs prod


-- Row count
SELECT COUNT(*) FROM olist_test.dbo.fact_sales_report;
SELECT COUNT(*) FROM olist_prod.dbo.fact_sales_report;


-- Distinct orders
SELECT COUNT(DISTINCT order_id) FROM olist_test.dbo.fact_sales_report;
SELECT COUNT(DISTINCT order_id) FROM olist_prod.dbo.fact_sales_report;


-- Revenue check
SELECT SUM(item_revenue) FROM olist_test.dbo.fact_sales_report;
SELECT SUM(item_revenue) FROM olist_prod.dbo.fact_sales_report;


