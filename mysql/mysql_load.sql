-- table separation and population code
-- author: Jerry Liu

-- check data
select * from orders_data;

-- load market
Insert into jsh_market (market_name)
select distinct  Market from orders_data;
-- test if loaded
-- select * from jsh_market;

-- load region
Insert into jsh_region (market_id, region_name)
SELECT DISTINCT  m.market_id,o.Region
FROM orders_data o
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
select distinct category from orders_data;

-- select * from jsh_catetory

Insert into jsh_sub_category (sub_category_name, category_id)
select distinct  o.`Sub-Category`,c.category_id
from orders_data o
join jsh_category c on c.category_name = o.Category

-- select * from jsh_sub_category

-- TODO: this part needs to be discussed and fixed
Insert into jsh_product (product_id, product_name, sub_category_id, market)
select distinct  o.`Product ID`, o.`Product Name`
from orders_data o
join jsh_sub_category c on c.sub_category_name = o.`Sub-Category`
