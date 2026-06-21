/*We’ve been spending a lot on discounts and promotions lately, 
and I need to understand whether those discounts are actually 
helping the business or simply reducing profitability.
I want you to analyze product category performance for the year 2024.
For each product category, show me:
    Total number of orders placed
    Total revenue generated
    Average discount percentage given
    Average profit margin percentage*/

SELECT
    p.category,
    COUNT(DISTINCT s.order_id) AS total_orders,
    SUM(s.revenue) AS total_revenue,
    ROUND((AVG(s.discount) * 100),2) AS avg_pct_discount,
    ROUND((SUM(s.profit) / SUM(s.revenue)) * 100, 2) AS profit_margin
FROM chocolate_sales.fact_sales s
JOIN chocolate_sales.dim_products p
    ON s.product_id = p.product_id
WHERE EXTRACT(YEAR FROM s.order_date) = 2024
GROUP BY p.category
ORDER BY SUM(s.revenue) DESC

/*
## What happened?
Discount levels are highly consistent across all product categories, 
averaging roughly **5.6%**, 
while profit margins remain almost identical at around **40%**.
**Praline** stands out as the strongest category, 
generating the highest revenue (**$3.33M**) and the highest number of orders.
This shows that despite discounts being applied across categories, 
overall profitability remains stable.

---

## Why did it happen?
The data suggests discounts are **not negatively impacting profitability**, 
but they are also **not the main factor driving revenue growth**.
Since both discount rates and profit margins remain nearly the same across categories, 
revenue differences are being driven primarily by **customer demand and sales volume**, 
not discount strategy.
In short, stronger categories are performing better because customers 
naturally buy more of them.

---

## What management should do
Management should focus less on increasing discounts 
and more on understanding **what drives demand** for top-performing categories 
like Praline and White.
Current discounting appears sustainable, 
but there is little evidence that offering more discounts 
would significantly improve business performance.
The priority should be **demand generation, not promotion-heavy growth strategies**.
