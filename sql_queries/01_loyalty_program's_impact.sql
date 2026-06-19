/*Executive problem statement:

"I need to look at our loyalty program's impact. 
For each store category (store_type), 
I want to see the total number of orders placed, 
the total net profit generated, 
and what percentage of that profit came from our registered loyalty members.
Show me these metrics only for our top-performing product category
 based on total revenue."*/

SELECT 
    st.store_type,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.profit) AS total_profit,
    ROUND(
        (SUM(CASE WHEN c.loyalty_member THEN s.profit ELSE 0 END) / SUM(s.profit)) * 100, 
        2
    ) AS pct_loyalty_profit
FROM chocolate_sales.fact_sales s
JOIN chocolate_sales.dim_stores st ON s.store_id = st.store_id
JOIN chocolate_sales.dim_customers c ON s.customer_id = c.customer_id
JOIN chocolate_sales.dim_products p ON s.product_id = p.product_id
WHERE p.category = (
    SELECT p2.category
    FROM chocolate_sales.fact_sales s2
    JOIN chocolate_sales.dim_products p2 ON s2.product_id = p2.product_id
    GROUP BY p2.category
    ORDER BY SUM(s2.revenue) DESC
    LIMIT 1
)
GROUP BY st.store_type
ORDER BY total_profit DESC;

/*using a CTE*/
WITH top_category AS (
    SELECT 
        p.category
    FROM chocolate_sales.fact_sales s
    JOIN chocolate_sales.dim_products p 
        ON s.product_id = p.product_id
    GROUP BY p.category
    ORDER BY SUM(s.revenue) DESC
    LIMIT 1
)
SELECT
    st.store_type,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.profit) AS total_profit,
    ROUND(
        (SUM(CASE WHEN c.loyalty_member THEN s.profit ELSE 0 END) / SUM(s.profit)) * 100, 
        2
    ) AS pct_loyalty_profit
FROM chocolate_sales.fact_sales s
JOIN chocolate_sales.dim_stores st ON s.store_id = st.store_id
JOIN chocolate_sales.dim_customers c ON s.customer_id = c.customer_id
JOIN chocolate_sales.dim_products p ON s.product_id = p.product_id

GROUP BY st.store_type
ORDER BY total_profit DESC;