WITH top_category AS (
    SELECT p.category
    FROM chocolate_sales.fact_sales s
    JOIN chocolate_sales.dim_products p ON s.product_id = p.product_id
    WHERE EXTRACT (YEAR FROM s.order_date) = 2024
    GROUP BY p.category
    ORDER BY SUM(s.revenue) DESC
    LIMIT 1
)
SELECT
    COUNT(DISTINCT s.order_id) as total_orders,
    SUM ( s.revenue) AS total_revenue,
    ROUND((SUM(s.profit)/ SUM(s.revenue) * 100),2) AS avg_pct_profit,
    ROUND((SUM(s.revenue) / COUNT(DISTINCT s.order_id)),2) AS avg_order_value,
    CASE 
        WHEN c.loyalty_member THEN 'loyalty_customers'
        ELSE 'non-loyalty_customers'
        END AS loyalty_bucket
FROM chocolate_sales.fact_sales s
JOIN chocolate_sales.dim_products p ON s.product_id = p.product_id
JOIN chocolate_sales.dim_customers c ON s.customer_id = c.customer_id
WHERE p.category = (SELECT category FROM top_category) 
    AND EXTRACT(YEAR FROM s.order_date) = 2024
GROUP BY 
    CASE 
    WHEN c.loyalty_member THEN 'loyalty_customers'
    ELSE 'non-loyalty_customers' END
ORDER BY SUM ( s.revenue) DESC
