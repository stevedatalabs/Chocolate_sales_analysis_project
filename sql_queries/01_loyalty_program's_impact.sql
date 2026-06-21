/*Executive problem statement:

"I need to look at our loyalty program's impact. 
For each store category (store_type), 
I want to see the total number of orders placed, 
the total net profit generated, 
and what percentage of that profit came from our registered loyalty members.
Show me these metrics only for our top-performing product category
 based on total revenue."*/

/*SELECT 
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
*/

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
WHERE p.category = (SELECT category FROM top_category)
GROUP BY st.store_type
ORDER BY total_profit DESC;

/*
### Executive Summary:
**What happened?**
The biggest thing that stands out is how incredibly consistent the loyalty program’s 
contribution is across all store categories.
* Airport → 50.06%
* Mall → 50.25%
* Online → 50.23%
* Retail → 50.08%
Roughly **50% of total profit across every sales channel is coming from loyalty members.**
This level of consistency immediately tells me that the loyalty program is not
concentrated in one part of the business.
It is performing almost uniformly across all store categories.
Although Airport stores generated the highest number of orders and highest profit, 
the more important insight here is that loyalty members are contributing 
almost equally to profitability regardless of where customers shop.

---

**Why did this happen?**
This suggests the loyalty program has been integrated effectively across the entire business.
In simple terms:
Whether a customer shops at Airport stores, Mall stores, Online, or Retail stores, 
loyalty members are generating profit at almost the same rate everywhere.
This could indicate:
* Strong customer adoption of the loyalty program
* Consistent customer retention across all channels
* Effective implementation of the loyalty strategy company-wide

---
**What should management do?**
Management should continue investing in the loyalty program because 
the data clearly shows it is a major driver of profitability.
One thing I would investigate further is this:
If loyalty members are contributing nearly **half of total profit**,
how can we increase loyalty enrollment even further?
Because improving loyalty adoption even slightly 
could have a significant impact on overall profitability.

Main takeaway:
The loyalty program is not just working.
It is working consistently across the entire business.
