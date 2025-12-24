\# **Dataset Overview**



Source:

\- Olist Brazilian E-Commerce Dataset

\- https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce



Description:

This dataset contains real commercial data from Olist, a Brazilian e-commerce marketplace.

It includes orders, customers, sellers, products, payments, and reviews.



Core Tables Used:

\- orders

\- order\_items

\- customers

\- products

\- payments

\- reviews



Time Period:

\- 2016 – 2018



Initial Data Issues Observed:

\- Missing product dimensions

\- Multiple payment rows per order

\- Inconsistent datetime formats (MySQL)

\- Orders without reviews



Note:

Raw CSV files were used only for database ingestion.

All reporting is done on cleaned, transformed fact tables.



