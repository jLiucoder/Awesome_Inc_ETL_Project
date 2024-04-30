-- table separation and population code
-- author: Jerry Liu, Satya Vamsi

-- check data
select * from jhs_hr_data;

-- load market
Insert into jsh_market (market_name)
select distinct  Market from jhs_hr_data;
-- test if loaded
-- select * from jsh_market;

-- load region
Insert into jsh_region (market_id, region_name)
SELECT DISTINCT  m.market_id,o.Region
FROM jhs_hr_data o
JOIN jsh_market m ON o.market = m.market_name;

-- country populating
Insert into jsh_country (country_name)
select distinct Country from jhs_hr_data;

-- populating region_country
Insert into jsh_region_country (region_id, country_id)
SELECT DISTINCT
    jr.region_id,
    jc.country_id
FROM
    jhs_hr_data jd
JOIN
    jsh_region jr
    ON jd.Region = jr.region_name
JOIN
    jsh_country jc
    ON jd.Country = jc.country_name;


-- populating state table
insert into jsh_state (state_name, country_id)
select distinct jd.State, jc.country_id from jsh_country jc
join jhs_hr_data jd on jc.country_name = jd.Country;

-- populating city table # this is correct
INSERT INTO jsh_city (city_name, state_id)
SELECT DISTINCT jd.City, js.state_id
FROM jhs_hr_data jd
JOIN jsh_state js ON js.state_name = jd.State;

-- populating the address table
insert into jsh_address (row_id, postal_code, city_id)
select distinct
    jcu.row_id,
    jd.`Postal Code`,
    jc.city_id
from jhs_hr_data jd
join
    jsh_city jc
    on jd.City = jc.city_name
join
    jsh_customer jcu
    on jd.`Row ID` = jcu.row_id;

Insert into jsh_category (category_name)
select distinct category from jhs_hr_data;

-- select * from jsh_catetory

Insert into jsh_sub_category (sub_category_name, category_id)
select distinct  o.`Sub-Category`,c.category_id
from jhs_hr_data o
join jsh_category c on c.category_name = o.Category

-- select * from jsh_sub_category

-- TODO: this part needs to be discussed and fixed
Insert into jsh_product (product_id, product_name, sub_category_id, market)
select distinct  o.`Product ID`, o.`Product Name`
from jhs_hr_data o
join jsh_sub_category c on c.sub_category_name = o.`Sub-Category`



-- Inserting into Customer Table
-- user_finals is a temporary table to store first and last names as hr data has full names
INSERT INTO jsh_customer (row_id, customer_id, customer_first_name, customer_last_name, segment)
SELECT
    j.`Row ID` as row_id,    
    j.`Customer ID`,
    u.first_name,
    u.last_name,
    j.`Segment`
FROM jhs_hr_data j, user_finals u
where j.`Row ID` = u.rows_id;

create table user_finals (
rows_id bigINT,
first_name VARCHAR(50),
last_name VARCHAR(50))


INSERT INTO user_finals (rows_id, first_name, last_name)
SELECT 
    `Row ID` as rows_id,
    SUBSTRING_INDEX(`Customer Name`, ' ', 1) AS first_name,
    SUBSTRING_INDEX(`Customer Name`, ' ', -1) AS last_name
FROM jhs_hr_data;

delete table user_finals


-- Inserting to order_product
INSERT INTO jsh_order_product (row_id, product_id, order_priority, sales, profit, quantity, discount, shipping_cost, ship_mode, ship_date)
SELECT
    c.row_id,
    p.product_id,
    d.`Order Priority`,
    CAST(REPLACE(d.`Sales`, '$', '') AS DECIMAL(10, 4)) AS sales,
    CAST(REPLACE(d.`Profit`, '$', '') AS DECIMAL(10, 4)) AS profit,
    d.`Quantity`,
    d.`Discount`,
    d.`Shipping Cost`,
    d.`Ship Mode`,
    DATE_FORMAT(STR_TO_DATE(d.`Order Date`, '%m/%d/%Y'), '%Y-%m-%d') AS order_date
FROM
    jhs_hr_data d
INNER JOIN
    jsh_customer c ON d.`Row ID` = c.row_id
INNER JOIN
    jsh_product p ON d.`Product ID` = p.product_id;

    
-- Inserting into Order table
INSERT INTO jsh_order (row_id, order_id, order_date, is_returned)
SELECT
    d.`Row ID` AS row_id,
    d.`Order ID` AS order_id,
    DATE_FORMAT(STR_TO_DATE(d.`Order Date`, '%m/%d/%Y'), '%Y-%m-%d') AS order_date,
    CASE
        WHEN r.`Order ID` IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS is_returned
FROM
    jhs_hr_data d
LEFT JOIN
    Hr_data_returns r ON d.`Order ID` = r.`Order ID`
    AND d.`Region` = r.`Region`;

