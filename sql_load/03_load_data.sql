\copy chocolate_sales.dim_customers 
(customer_id, age, gender, loyalty_member, join_date)
from 'C:\Users\user\Desktop\Chocolate_sales_project_analysis\csv_files\customers.csv' 
WITH (
    FORMAT csv,
    HEADER TRUE,
    DELIMITER ','
    ENCODING 'UTF8'
);

\copy chocolate_sales.dim_products 
(product_id, product_name, brand, category, cocoa_percent, weight_g)
FROM 'C:\Users\user\Desktop\Chocolate_sales_project_analysis\csv_files\products.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    ENCODING 'UTF8'
);

\copy chocolate_sales.dim_stores 
(store_id, store_name, city, country, store_type)
FROM 'C:\Users\user\Desktop\Chocolate_sales_project_analysis\csv_files\stores.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    ENCODING 'UTF8'
);

\copy chocolate_sales.dim_calendar
(date, year, month_number, month_name, quarter, year_month, date_key, week_number, weekday_number, weekday_name, month_short)
FROM 'C:\Users\user\Desktop\Chocolate_sales_project_analysis\csv_files\calendar.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    ENCODING 'UTF8'
);

\copy chocolate_sales.fact_sales 
(order_id, order_date, product_id, store_id, customer_id, quantity, unit_price, discount, revenue, cost, profit)
FROM 'C:\Users\user\Desktop\Chocolate_sales_project_analysis\csv_files\sales.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    ENCODING 'UTF8'
);  