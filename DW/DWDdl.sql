CREATE TABLE DIM_DATE AS
SELECT
 n AS ENTRY_ID,
 TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS Full_Date,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS Days,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Mon') AS Month_Short,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') AS Month_Num,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month') AS Month_Long,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'D') AS Day_Of_Week_Short,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Day') AS Day_Of_Week_Long,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS Year,
 CASE
 WHEN TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') IN (1,2,3) THEN 'Q1'
 WHEN TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') IN (4,5,6) THEN 'Q2'
 WHEN TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') IN (7,8,9) THEN 'Q3'
 ELSE
 'Q4'
 END Quarter,
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')||
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')||
 TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')
 AS DATE_ID
FROM (
 select level n
 from dual
 connect by level <= 36600
); 
ALTER TABLE DIM_DATE ADD CONSTRAINT PK_DIM_DATE PRIMARY KEY (DATE_ID);


CREATE TABLE dim_jsh_address (
    address_id  NUMBER(2) NOT NULL,
    postal_code VARCHAR2(10),
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_address.address_id IS
    'unique address ID';

COMMENT ON COLUMN dim_jsh_address.postal_code IS
    'postal code';

COMMENT ON COLUMN dim_jsh_address.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_address ADD CONSTRAINT dim_jsh_address_pk PRIMARY KEY ( address_id );

CREATE TABLE dim_jsh_category (
    category_id   NUMBER(3) NOT NULL,
    category_name VARCHAR2(20) NOT NULL,
    tbl_last_dt   TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_category.category_id IS
    'unique category identifier';

COMMENT ON COLUMN dim_jsh_category.category_name IS
    'category name';

COMMENT ON COLUMN dim_jsh_category.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_category ADD CONSTRAINT dim_jsh_category_pk PRIMARY KEY ( category_id );

CREATE TABLE dim_jsh_city (
    city_id     NUMBER(2) NOT NULL,
    city_name   VARCHAR2(30) NOT NULL,
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_city.city_id IS
    'unique city identifier';

COMMENT ON COLUMN dim_jsh_city.city_name IS
    'city name';

COMMENT ON COLUMN dim_jsh_city.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_city ADD CONSTRAINT dim_jsh_city_pk PRIMARY KEY ( city_id );

CREATE TABLE dim_jsh_country (
    country_id   NUMBER(2) NOT NULL,
    country_name VARCHAR2(30) NOT NULL,
    tbl_last_dt  TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_country.country_id IS
    'unique country id';

COMMENT ON COLUMN dim_jsh_country.country_name IS
    'country name';

COMMENT ON COLUMN dim_jsh_country.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_country ADD CONSTRAINT dim_jsh_country_pk PRIMARY KEY ( country_id );

CREATE TABLE dim_jsh_customer (
    row_id              NUMBER(10) NOT NULL,
    customer_id         VARCHAR2(20) NOT NULL,
    customer_first_name VARCHAR2(10) NOT NULL,
    customer_last_name  VARCHAR2(10) NOT NULL,
    segment             VARCHAR2(15) NOT NULL,
    tbl_last_dt         TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_customer.row_id IS
    'since customer id is not unique, we use row id as the unique identifier in customer table';

COMMENT ON COLUMN dim_jsh_customer.customer_id IS
    'customer id record';

COMMENT ON COLUMN dim_jsh_customer.customer_first_name IS
    'c first name';

COMMENT ON COLUMN dim_jsh_customer.customer_last_name IS
    'c last name';

COMMENT ON COLUMN dim_jsh_customer.segment IS
    'segment ';

COMMENT ON COLUMN dim_jsh_customer.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_customer ADD CONSTRAINT dim_jsh_customer_pk PRIMARY KEY ( row_id );

CREATE TABLE dim_jsh_market (
    market_id   NUMBER(2) NOT NULL,
    market_name VARCHAR2(30) NOT NULL,
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_market.market_id IS
    'unique market identifier';

COMMENT ON COLUMN dim_jsh_market.market_name IS
    'market name';

COMMENT ON COLUMN dim_jsh_market.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_market ADD CONSTRAINT dim_jsh_market_pk PRIMARY KEY ( market_id );

CREATE TABLE dim_jsh_order (
    row_id      NUMBER(10) NOT NULL,
    order_id    NUMBER(38) NOT NULL,
    order_date  DATE NOT NULL,
    is_returned CHAR(1) NOT NULL,
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_order.row_id IS
    'row id as the pk for orders, since order id is not unique';

COMMENT ON COLUMN dim_jsh_order.order_id IS
    'order id for orders';

COMMENT ON COLUMN dim_jsh_order.order_date IS
    'The date the order was placed';

COMMENT ON COLUMN dim_jsh_order.is_returned IS
    'If the order was returned or not';

COMMENT ON COLUMN dim_jsh_order.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_order ADD CONSTRAINT dim_jsh_order_pk PRIMARY KEY ( row_id );

CREATE TABLE dim_jsh_product (
    product_id   VARCHAR2(20) NOT NULL,
    product_name VARCHAR2(20) NOT NULL,
    tbl_last_dt  TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_product.product_id IS
    'unique product id';

COMMENT ON COLUMN dim_jsh_product.product_name IS
    'product name';

COMMENT ON COLUMN dim_jsh_product.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_product ADD CONSTRAINT dim_jsh_product_pk PRIMARY KEY ( product_id );

CREATE TABLE dim_jsh_region (
    region_id   NUMBER(2) NOT NULL,
    region_name VARCHAR2(30) NOT NULL,
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_region.region_id IS
    'unique region identifier';

COMMENT ON COLUMN dim_jsh_region.region_name IS
    'region name';

COMMENT ON COLUMN dim_jsh_region.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_region ADD CONSTRAINT dim_jsh_region_pk PRIMARY KEY ( region_id );

CREATE TABLE dim_jsh_state (
    state_id    NUMBER(2) NOT NULL,
    state_name  VARCHAR2(30) NOT NULL,
    tbl_last_dt TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_state.state_id IS
    'unique state identifier';

COMMENT ON COLUMN dim_jsh_state.state_name IS
    'state name';

COMMENT ON COLUMN dim_jsh_state.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_state ADD CONSTRAINT dim_jsh_state_pk PRIMARY KEY ( state_id );

CREATE TABLE dim_jsh_sub_category (
    sub_category_id   NUMBER(3) NOT NULL,
    sub_category_name VARCHAR2(15) NOT NULL,
    tbl_last_dt       TIMESTAMP NOT NULL
);

COMMENT ON COLUMN dim_jsh_sub_category.sub_category_id IS
    'unique sub category identifier';

COMMENT ON COLUMN dim_jsh_sub_category.sub_category_name IS
    'subcategory name';

COMMENT ON COLUMN dim_jsh_sub_category.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE dim_jsh_sub_category ADD CONSTRAINT dim_jsh_sub_category_pk PRIMARY KEY ( sub_category_id );


CREATE TABLE fact_jsh_order_product (
    row_id          NUMBER(10) NOT NULL,
    product_id      VARCHAR2(20) NOT NULL,
    order_priority  VARCHAR2(10) NOT NULL,
    sales           NUMBER(12) NOT NULL,
    profit          NUMBER(12, 2) NOT NULL,
    quantity        NUMBER(3) NOT NULL,
    discount        NUMBER(3, 2) NOT NULL,
    shipping_cost   NUMBER(7, 3) NOT NULL,
    ship_mode       VARCHAR2(20) NOT NULL,
    ship_date       DATE NOT NULL,
    tbl_last_dt     TIMESTAMP NOT NULL,
    sub_category_id NUMBER(3) NOT NULL,
    category_id     NUMBER(3) NOT NULL,
    address_id      NUMBER(2) NOT NULL,
    region_id       NUMBER(2) NOT NULL,
    market_id       NUMBER(2) NOT NULL,
    country_id      NUMBER(2) NOT NULL,
    state_id        NUMBER(2) NOT NULL,
    city_id         NUMBER(2) NOT NULL,
    date_id         VARCHAR2(8) NOT NULL
);

COMMENT ON COLUMN fact_jsh_order_product.order_priority IS
    'order priority ';

COMMENT ON COLUMN fact_jsh_order_product.sales IS
    'sales amount';

COMMENT ON COLUMN fact_jsh_order_product.profit IS
    'profit amount';

COMMENT ON COLUMN fact_jsh_order_product.quantity IS
    'quantity of the item';

COMMENT ON COLUMN fact_jsh_order_product.discount IS
    'Discount in decimal format (0.xx)';

COMMENT ON COLUMN fact_jsh_order_product.shipping_cost IS
    'shipping cost in decimal format (xxx.xxx)';

COMMENT ON COLUMN fact_jsh_order_product.ship_mode IS
    'ship mode: first class, second class, same day, standard class.';

COMMENT ON COLUMN fact_jsh_order_product.ship_date IS
    'ship date in date format';

COMMENT ON COLUMN fact_jsh_order_product.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ;

ALTER TABLE fact_jsh_order_product ADD CONSTRAINT fact_jsh_order_product_pk PRIMARY KEY ( product_id,
                                                                                          row_id );


 --ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_date_fk FOREIGN KEY ( date_id )
        REFERENCES dim_date ( date_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_address_fk FOREIGN KEY ( address_id )
        REFERENCES dim_jsh_address ( address_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_category_fk FOREIGN KEY ( category_id )
        REFERENCES dim_jsh_category ( category_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_city_fk FOREIGN KEY ( city_id )
        REFERENCES dim_jsh_city ( city_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_country_fk FOREIGN KEY ( country_id )
        REFERENCES dim_jsh_country ( country_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_customer_fk FOREIGN KEY ( row_id )
        REFERENCES dim_jsh_customer ( row_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_market_fk FOREIGN KEY ( market_id )
        REFERENCES dim_jsh_market ( market_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_order_fk FOREIGN KEY ( row_id )
        REFERENCES dim_jsh_order ( row_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_product_fk FOREIGN KEY ( product_id )
        REFERENCES dim_jsh_product ( product_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_region_fk FOREIGN KEY ( region_id )
        REFERENCES dim_jsh_region ( region_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_state_fk FOREIGN KEY ( state_id )
        REFERENCES dim_jsh_state ( state_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE fact_jsh_order_product
    ADD CONSTRAINT fact_order_product_dim_sub_category_fk FOREIGN KEY ( sub_category_id )
        REFERENCES dim_jsh_sub_category ( sub_category_id );
