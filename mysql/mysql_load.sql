-- table seperation and population code
-- author: jerry liu

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

-- test if loaded
-- select * from jsh_region


-- TODO：why there are several U.S. regions and the country is all United States, and country table have dups for united states
-- TODO: skip to discuss

-- insert into jsh_country (country_name, region_id)
-- select distinct  o.country,c.region_id
-- from orders_data o
-- join jsh_region c on o.Region = c.region_name;

-- test if loaded
-- select * from jsh_country

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