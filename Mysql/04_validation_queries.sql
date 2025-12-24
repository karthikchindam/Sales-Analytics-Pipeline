

/* validation*/

SELECT COUNT(DISTINCT order_id) FROM fact_sales_report;



SELECT ROUND(SUM(item_revenue)/1000000,2) FROM fact_sales_report;
