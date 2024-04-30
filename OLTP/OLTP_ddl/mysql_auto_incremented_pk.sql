-- this version of mysql code has modified the length of some properties, and also added auto_increment
-- to the locations tables and category tables
show databases;

create database jsh_DB;

-- SQLINES DEMO *** le SQL Developer Data Modeler 23.1.0.087.0806
-- SQLINES DEMO *** -02-27 01:34:49 EST
-- SQLINES DEMO *** le Database 11g
-- SQLINES DEMO *** le Database 11g

use jsh_DB;

-- SQLINES DEMO *** no DDL - MDSYS.SDO_GEOMETRY

-- SQLINES DEMO *** no DDL - XMLTYPE

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_address (
    city_id     BIGINT NOT NULL ,
    address_id  BIGINT NOT NULL COMMENT 'unique address ID',
    postal_code VARCHAR(10) COMMENT 'postal code',
    row_id      BIGINT NOT NULL,
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_address.address_id IS
    'unique address ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_address.postal_code IS
    'postal code'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_address.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_address ADD CONSTRAINT jsh_address_pk PRIMARY KEY ( address_id );
ALTER TABLE jsh_address
    CHANGE COLUMN address_id address_id BIGINT NOT NULL AUTO_INCREMENT;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_category (
    category_id   INT NOT NULL COMMENT 'unique category identifier',
    category_name VARCHAR(20) NOT NULL COMMENT 'category name',
    tbl_last_dt   DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_category.category_id IS
    'unique category identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_category.category_name IS
    'category name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_category.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_category ADD CONSTRAINT jsh_category_pk PRIMARY KEY ( category_id );
ALTER TABLE jsh_category
    CHANGE COLUMN category_id category_id INT NOT NULL AUTO_INCREMENT;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_city (
    city_id     BIGINT NOT NULL COMMENT 'unique city identifier',
    city_name   VARCHAR(30) NOT NULL COMMENT 'city name',
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.',
    state_id    BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_city.city_id IS
    'unique city identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_city.city_name IS
    'city name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_city.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_city ADD CONSTRAINT jsh_city_pk PRIMARY KEY ( city_id );
ALTER TABLE jsh_city
    CHANGE COLUMN city_id city_id BIGINT NOT NULL AUTO_INCREMENT;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_country (
    country_id   BIGINT NOT NULL COMMENT 'unique country id',
    country_name VARCHAR(50) NOT NULL COMMENT 'country name',
    tbl_last_dt  DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.',
    region_id    BIGINT NOT NULL
);


/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_country.country_id IS
    'unique country id'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_country.country_name IS
    'country name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_country.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_country ADD CONSTRAINT jsh_country_pk PRIMARY KEY ( country_id );
ALTER TABLE jsh_country
    CHANGE COLUMN country_id country_id BIGINT NOT NULL AUTO_INCREMENT;
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_customer (
    row_id              BIGINT NOT NULL COMMENT 'since customer id is not unique, we use row id as the unique identifier in customer table',
    customer_id         VARCHAR(20) NOT NULL COMMENT 'customer id record',
    customer_first_name VARCHAR(10) NOT NULL COMMENT 'c first name',
    customer_last_name  VARCHAR(10) NOT NULL COMMENT 'c last name',
    segment             VARCHAR(15) NOT NULL COMMENT 'segment ',
    tbl_last_dt         DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.row_id IS
    'since customer id is not unique, we use row id as the unique identifier in customer table'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.customer_id IS
    'customer id record'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.customer_first_name IS
    'c first name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.customer_last_name IS
    'c last name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.segment IS
    'segment '; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_customer.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_customer ADD CONSTRAINT jsh_customer_pk PRIMARY KEY ( row_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_market (
    market_id   BIGINT NOT NULL COMMENT 'unique market identifier',
    market_name VARCHAR(30) NOT NULL COMMENT 'market name',
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_market.market_id IS
    'unique market identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_market.market_name IS
    'market name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_market.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_market ADD CONSTRAINT jsh_market_pk PRIMARY KEY ( market_id );
ALTER TABLE jsh_market
    CHANGE COLUMN market_id market_id BIGINT NOT NULL AUTO_INCREMENT;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_order (
    row_id      BIGINT NOT NULL COMMENT 'row id as the pk for orders, since order id is not unique',
    order_id    DECIMAL(40) NOT NULL COMMENT 'order id for orders',
    order_date  DATETIME NOT NULL COMMENT 'The date the order was placed',
    is_returned CHAR(1) NOT NULL COMMENT 'If the order was returned or not',
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order.row_id IS
    'row id as the pk for orders, since order id is not unique'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order.order_id IS
    'order id for orders'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order.order_date IS
    'The date the order was placed'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order.is_returned IS
    'If the order was returned or not'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_order ADD CONSTRAINT jsh_order_pk PRIMARY KEY ( row_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_order_product (
    row_id         BIGINT NOT NULL,
    product_id     VARCHAR(20) NOT NULL,
    order_priority VARCHAR(10) NOT NULL COMMENT 'order priority ',
    sales          BIGINT NOT NULL COMMENT 'sales amount',
    profit         DECIMAL(12, 2) NOT NULL COMMENT 'profit amount',
    quantity       SMALLINT NOT NULL COMMENT 'quantity of the item',
    discount       DECIMAL(3, 2) NOT NULL COMMENT 'Discount in decimal format (0.xx)',
    shipping_cost  DECIMAL(7, 3) NOT NULL COMMENT 'shipping cost in decimal format (xxx.xxx)',
    ship_mode      VARCHAR(20) NOT NULL COMMENT 'ship mode: first class, second class, same day, standard class.',
    ship_date      DATETIME NOT NULL COMMENT 'ship date in date format',
    tbl_last_dt    DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.order_priority IS
    'order priority '; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.sales IS
    'sales amount'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.profit IS
    'profit amount'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.quantity IS
    'quantity of the item'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.discount IS
    'Discount in decimal format (0.xx)'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.shipping_cost IS
    'shipping cost in decimal format (xxx.xxx)'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.ship_mode IS
    'ship mode: first class, second class, same day, standard class.'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.ship_date IS
    'ship date in date format'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_order_product.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_order_product ADD CONSTRAINT jsh_order_product_pk PRIMARY KEY ( product_id,
                                                                                row_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_product (
    product_id      VARCHAR(20) NOT NULL COMMENT 'unique product id',
    product_name    VARCHAR(100) NOT NULL COMMENT 'product name',
    sub_category_id INT NOT NULL,
    market          VARCHAR(20) NOT NULL COMMENT 'Specifies which Market it belongs to',
    tbl_last_dt     DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_product.product_id IS
    'unique product id'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_product.product_name IS
    'product name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_product.market IS
    'Specifies which Market it belongs to'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_product.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_product ADD CONSTRAINT jsh_product_pk PRIMARY KEY ( product_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_region (
    market_id   BIGINT NOT NULL,
    region_id   BIGINT NOT NULL COMMENT 'unique region identifier',
    region_name VARCHAR(30) NOT NULL COMMENT 'region name',
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_region.region_id IS
    'unique region identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_region.region_name IS
    'region name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_region.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_region ADD CONSTRAINT jsh_region_pk PRIMARY KEY ( region_id );
ALTER TABLE jsh_region
    CHANGE COLUMN region_id region_id BIGINT  NOT NULL AUTO_INCREMENT;


-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_state (
    state_id    BIGINT NOT NULL COMMENT 'unique state identifier',
    state_name  VARCHAR(30) NOT NULL COMMENT 'state name',
    tbl_last_dt DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.',
    country_id  BIGINT NOT NULL
);


/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_state.state_id IS
    'unique state identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_state.state_name IS
    'state name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_state.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_state ADD CONSTRAINT jsh_state_pk PRIMARY KEY ( state_id );
ALTER TABLE jsh_state
    CHANGE COLUMN state_id state_id BIGINT NOT NULL AUTO_INCREMENT;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE jsh_sub_category (
    sub_category_id   INT NOT NULL COMMENT 'unique sub category identifier',
    sub_category_name VARCHAR(30) NOT NULL COMMENT 'subcategory name',
    category_id       INT NOT NULL,
    tbl_last_dt       DATETIME(6) NOT NULL COMMENT 'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_sub_category.sub_category_id IS
    'unique sub category identifier'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_sub_category.sub_category_name IS
    'subcategory name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN jsh_sub_category.tbl_last_dt IS
    'This column is updated with system timestamp via trigger, whenever record is inserted/updated. This is required to facilitate CDC base incremental ETL to DW system.'
    ; */

ALTER TABLE jsh_sub_category ADD CONSTRAINT jsh_sub_category_pk PRIMARY KEY ( sub_category_id );
ALTER TABLE jsh_sub_category
    CHANGE COLUMN sub_category_id sub_category_id INT NOT NULL AUTO_INCREMENT;


ALTER TABLE jsh_address
    ADD CONSTRAINT jsh_address_jsh_city_fk FOREIGN KEY ( city_id )
        REFERENCES jsh_city ( city_id );

ALTER TABLE jsh_address
    ADD CONSTRAINT jsh_address_jsh_customer_fk FOREIGN KEY ( row_id )
        REFERENCES jsh_customer ( row_id );

ALTER TABLE jsh_city
    ADD CONSTRAINT jsh_city_jsh_state_fk FOREIGN KEY ( state_id )
        REFERENCES jsh_state ( state_id );

ALTER TABLE jsh_country
    ADD CONSTRAINT jsh_country_jsh_region_fk FOREIGN KEY ( region_id )
        REFERENCES jsh_region ( region_id );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30)
ALTER TABLE jsh_order_product
    ADD CONSTRAINT jsh_order_product_jsh_customer_fk FOREIGN KEY ( row_id )
        REFERENCES jsh_customer ( row_id );

ALTER TABLE jsh_order_product
    ADD CONSTRAINT jsh_order_product_jsh_order_fk FOREIGN KEY ( row_id )
        REFERENCES jsh_order ( row_id );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30)
ALTER TABLE jsh_order_product
    ADD CONSTRAINT jsh_order_product_jsh_product_fk FOREIGN KEY ( product_id )
        REFERENCES jsh_product ( product_id );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30)
ALTER TABLE jsh_product
    ADD CONSTRAINT jsh_product_jsh_sub_category_fk FOREIGN KEY ( sub_category_id )
        REFERENCES jsh_sub_category ( sub_category_id );

ALTER TABLE jsh_region
    ADD CONSTRAINT jsh_region_jsh_market_fk FOREIGN KEY ( market_id )
        REFERENCES jsh_market ( market_id );

ALTER TABLE jsh_state
    ADD CONSTRAINT jsh_state_jsh_country_fk FOREIGN KEY ( country_id )
        REFERENCES jsh_country ( country_id );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30)
ALTER TABLE jsh_sub_category
    ADD CONSTRAINT jsh_sub_category_jsh_category_fk FOREIGN KEY ( category_id )
        REFERENCES jsh_category ( category_id );


# insert and update trigger for market
DELIMITER &&
create trigger TI_MARKET_default_date
    before insert
    on jsh_market
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_MARKET_default_date
    before update
    on jsh_market
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;


-- # insert and update trigger for region
DELIMITER &&
create trigger TI_REGION_default_date
    before insert
    on jsh_region
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_REGION_default_date
    before update
    on jsh_region
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for country
DELIMITER &&
create trigger TI_COUNTRY_default_date
    before insert
    on jsh_country
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_COUNTRY_default_date
    before update
    on jsh_country
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for state
DELIMITER &&
create trigger TI_STATE_default_date
    before insert
    on jsh_state
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_STATE_default_date
    before update
    on jsh_state
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for city
DELIMITER &&
create trigger TI_CITY_default_date
    before insert
    on jsh_city
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_CITY_default_date
    before update
    on jsh_city
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for address, which contains postal code
DELIMITER &&
create trigger TI_ADDRESS_default_date
    before insert
    on jsh_address
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_ADDRESS_default_date
    before update
    on jsh_address
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

# insert and update trigger for customer
DELIMITER &&
create trigger TI_CUSTOMER_default_date
    before insert
    on jsh_customer
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_CUSTOMER_default_date
    before update
    on jsh_customer
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

# insert and update trigger for order_product
DELIMITER &&
create trigger TI_ORDER_PRODUCT_default_date
    before insert
    on jsh_order_product
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_ORDER_PRODUCT_default_date
    before update
    on jsh_order_product
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for order
DELIMITER &&
create trigger TI_ORDER_default_date
    before insert
    on jsh_order
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_ORDER_default_date
    before update
    on jsh_order
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;


-- # insert and update trigger for category
DELIMITER &&
create trigger TI_CATEGORY_default_date
    before insert
    on jsh_category
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_CATEGORY_default_date
    before update
    on jsh_category
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update trigger for sub-category
DELIMITER &&
create trigger TI_SUB_CATEGORY_default_date
    before insert
    on jsh_sub_category
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_SUB_CATEGORY_default_date
    before update
    on jsh_sub_category
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # insert and update for product
DELIMITER &&
create trigger TI_PRODUCT_default_date
    before insert
    on jsh_product
    for each row
begin
    IF new.tbl_last_dt IS NULL THEN
        SET new.tbl_last_dt = current_timestamp();
    END IF;
end&&
DELIMITER ;

DELIMITER &&
create trigger TU_PRODUCT_default_date
    before update
    on jsh_product
    for each row
begin
    set new.tbl_last_dt = current_timestamp();
end&&
DELIMITER ;

-- # show triggers;


-- SQLINES DEMO *** per Data Modeler Summary Report:
--
-- SQLINES DEMO ***                        12
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                        23
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** DY                      0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE BODY              0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** EGMENT                  0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** ED VIEW                 0
-- SQLINES DEMO *** ED VIEW LOG             0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
--
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
--
-- SQLINES DEMO ***                         0
--
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** A                       0
-- SQLINES DEMO *** T                       0
--
-- SQLINES DEMO ***                         4
-- SQLINES DEMO ***                         0
