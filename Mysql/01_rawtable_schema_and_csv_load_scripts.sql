
create database olist_mysql;
use olist_mysql;


/* raw tables schema*/

create table reviews
(
review_id varchar(225),
order_id varchar(225),
review_score double,
review_creation_date varchar(225),
review_answer_timestamp varchar(225)
);

select * from reviews;

 

TRUNCATE TABLE reviews;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from reviews;



create table products
(
product_id varchar(255),
product_category_name varchar(225),
product_name_lenght tinyint,
product_description_lenght double,
product_photos_qty double,
product_weight_g double,
product_length_cm double,
product_height_cm double,
product_width_cm double
);

ALTER TABLE products
MODIFY product_name_lenght INT,
MODIFY product_description_lenght INT,
MODIFY product_photos_qty INT;

select * from products;

TRUNCATE TABLE products;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  product_id,
  product_category_name,
  @product_name_lenght,
  @product_description_lenght,
  @product_photos_qty,
  @product_weight_g,
  @product_length_cm,
  @product_height_cm,
  @product_width_cm
)
SET
  product_name_lenght = NULLIF(@product_name_lenght, ''),
  product_description_lenght = NULLIF(@product_description_lenght, ''),
  product_photos_qty = NULLIF(@product_photos_qty, ''),
  product_weight_g = NULLIF(@product_weight_g, ''),
  product_length_cm = NULLIF(@product_length_cm, ''),
  product_height_cm = NULLIF(@product_height_cm, ''),
  product_width_cm = NULLIF(@product_width_cm, '');

select * from products;



