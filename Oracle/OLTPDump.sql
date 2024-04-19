-- AWS RDS doesnt support using outfile nativly, so export it in editor is a must
SELECT market_id, market_name, tbl_last_dt
from jsh_market;

select region_id, region_name, tbl_last_dt
from jsh_region;

SELECT country_id, country_name, tbl_last_dt
    -- into outfile 'fullstg_dim_jsh_countries.csv'
    -- FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
from jsh_country;

select state_id, state_name, tbl_last_dt from jsh_state;

select city_id, city_name, tbl_last_dt from jsh_city;

select address_id, COALESCE(postal_code, 'NULL'), tbl_last_dt from jsh_address;

select row_id, customer_id, customer_first_name, customer_last_name, segment, tbl_last_dt from jsh_customer

select * from jsh_order;

select * from jsh_category;

select sub_category_id, sub_category_name, tbl_last_dt from jsh_sub_category;

select product_id, product_name, tbl_last_dt from jsh_product;

select op.*, subcate.sub_category_id, mar.market_id, reg.region_id, con.country_id, state.state_id, city.city_id, address.address_id   from jsh_market mar
join jsh_region reg on mar.market_id = reg.market_id
join jsh_region_country regcon on reg.region_id = regcon.region_id
join jsh_country con on regcon.country_id = con.country_id
join jsh_state state on con.country_id = state.country_id
join jsh_city city on state.state_id = city.state_id
join jsh_address address on address.city_id = city.city_id
join jsh_customer customer on address.row_id = customer.row_id
join jsh_order_product op on customer.row_id = op.row_id
join jsh_product p
    on op.product_id = p.product_id
join jsh_sub_category subcate
    on p.sub_category_id = subcate.sub_category_id
join jsh_category j on subcate.category_id = j.category_id;
