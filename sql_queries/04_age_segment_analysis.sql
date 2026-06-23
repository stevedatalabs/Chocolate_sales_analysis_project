/*
As our Chief Marketing Officer (CMO), 
I am preparing our global audience targeting strategy.
We need to know who our buyer is so we can optimize our marketing spend.
"Our marketing spend is currently distributed evenly across all age brackets, 
but I suspect certain age groups are carrying our business. 
For the year 2024, I want to see a clear profile of our customers broken 
into three distinct age buckets: 'Young Adults' (under 30), 
Middle-Aged' (30 to 50), and 'Seniors' (over 50).

For each of these three groups, tell me: 
the total number of unique customers who purchased from us, 
the total quantity of products bought, the total net profit generated, 
and the average revenue per order. 
Sort the results so the most profitable age bracket is sitting at the very top."
*/
SELECT
    CASE 
        WHEN c.age < 30 THEN 'young_adults'
        WHEN c.age BETWEEN 30 AND 50  THEN 'middle_aged'
        ELSE 'seniors'
        END AS age_bucket,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(s.quantity) AS total_quantity,
    SUM(s.profit) AS total_profit,
    ROUND(SUM(s.revenue)/COUNT(DISTINCT s.order_id),2) AS avg_revenue_per_order
FROM chocolate_sales.fact_sales s 
JOIN chocolate_sales.dim_customers c ON s.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM s.order_date) = 2024
GROUP BY 
    CASE 
        WHEN c.age < 30 THEN 'young_adults'
        WHEN c.age BETWEEN 30 AND 50  THEN 'middle_aged'
        ELSE 'seniors'
        END 
ORDER BY total_profit DESC;

/*
The CMO's Executive Takeaway:
"Our Middle-Aged segment is our primary engine, driving over $2 million in profit. 
However, our Seniors are a close second and hold nearly identical purchasing habits 
(spending $25.45 per order vs. $25.51 for Middle-Aged). 
Our Young Adults represent our smallest customer footprint 
and profit generation. We should immediately reallocate a portion 
of our youth marketing budget toward deeper engagement 
with the Middle-Aged and Senior cohorts to maximize ROI."
*/