CREATE SCHEMA IF NOT EXISTS chocolate_sales;

CREATE TABLE IF NOT EXISTS chocolate_sales.dim_customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    age INTEGER,
    gender VARCHAR(20),
    loyalty_member BOOLEAN,
    join_date DATE
);

CREATE TABLE IF NOT EXISTS chocolate_sales.dim_products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    brand VARCHAR(50),
    category VARCHAR(50),
    cocoa_percent INTEGER,
    weight_g INTEGER
);

CREATE TABLE IF NOT EXISTS chocolate_sales.dim_stores (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    store_type VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS chocolate_sales.dim_calendar (
    date DATE PRIMARY KEY,
    year INTEGER,
    month_number INTEGER,
    month_name VARCHAR(20),
    quarter VARCHAR(10),
    year_month VARCHAR(10),
    date_key INTEGER,
    week_number INTEGER,
    weekday_number INTEGER,
    weekday_name VARCHAR(20),
    month_short VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS chocolate_sales.fact_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    store_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    quantity INTEGER,
    unit_price NUMERIC(10, 2),
    discount NUMERIC(5, 2),
    revenue NUMERIC(12, 2),
    cost NUMERIC(12, 2),
    profit NUMERIC(12, 2),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id) REFERENCES chocolate_sales.dim_products (product_id),
    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_id) REFERENCES chocolate_sales.dim_stores (store_id),
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id) REFERENCES chocolate_sales.dim_customers (customer_id),
    CONSTRAINT fk_sales_date
        FOREIGN KEY (order_date) REFERENCES chocolate_sales.dim_calendar (date)
);

CREATE INDEX IF NOT EXISTS idx_fact_sales_order_date
    ON chocolate_sales.fact_sales (order_date);

CREATE INDEX IF NOT EXISTS idx_fact_sales_product_id
    ON chocolate_sales.fact_sales (product_id);

CREATE INDEX IF NOT EXISTS idx_fact_sales_store_id
    ON chocolate_sales.fact_sales (store_id);

CREATE INDEX IF NOT EXISTS idx_fact_sales_customer_id
    ON chocolate_sales.fact_sales (customer_id);