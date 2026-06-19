SELECT 'dim_customers' AS table_name, COUNT(*) AS row_count FROM chocolate_sales.dim_customers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM chocolate_sales.dim_products
UNION ALL
SELECT 'dim_stores', COUNT(*) FROM chocolate_sales.dim_stores
UNION ALL
SELECT 'dim_calendar', COUNT(*) FROM chocolate_sales.dim_calendar
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM chocolate_sales.fact_sales;