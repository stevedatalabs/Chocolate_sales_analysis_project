/*"I am reviewing our performance across different countries. 
For each country, I need to see our overall financial health for the year 2024. 
Specifically, show me the total quantity of products sold, 
    the total revenue generated, 
        and the average profit margin percentage. 
Oh, and I only want to see countries where our total revenue exceeded 2 million dollars in 2024, 
sorted from highest revenue to lowest."*/


SELECT
    st.country,
    SUM(s.quantity) as total_quantity,
    SUM(s.revenue) as total_revenue,
    ROUND((SUM(s.profit) / SUM(s.revenue)) * 100, 2)  AS profit_pct
FROM chocolate_sales.fact_sales s
JOIN chocolate_sales.dim_stores st  
    ON s.store_id = st.store_id
WHERE EXTRACT(YEAR from s.order_date) = 2024
GROUP BY st.country
HAVING SUM(s.revenue) > 2000000
ORDER BY SUM(s.revenue) DESC;

/*Executive Summary:

**What happened?**
Australia is clearly our strongest performing market. 
It has the highest revenue generated at $3.19M and 
also the highest quantity sold, meaning revenue here is 
strongly tied to product volume sold.
I also noticed that as revenue increases, profit percentage slightly decreases, 
although the difference is very insignificant, so it is not enough to conclude 
there is any strong inverse relationship.
Another thing I observed is that profit margins are almost identical across all countries,
averaging around 40%.
**This suggests a few things:
Similar pricing strategies across countries
Similar production cost structures
Consistent business operations globally
I also noticed something interesting with France.
France generates less money overall compared to the other countries, 
but it is slightly more efficient, meaning every dollar earned in France 
produces slightly more profit compared to the others.

**Why did this happen?**
Australia most likely has stronger customer demand, 
which explains why it has both the highest quantity sold and highest revenue generated.
This suggests that revenue growth in this business is mainly volume-driven, 
not margin-driven.
In other words:
Higher revenue is coming from selling more products, 
not necessarily from having better profitability.
As for France, there could be cost efficiencies in operations 
that are allowing the company to keep slightly more profit per dollar earned.

**What should management do?**
Management should investigate what is driving Australia’s strong sales volume and 
see whether those success factors can be replicated in lower-performing countries.
At the same time, France should be studied from an operational perspective 
to understand what is making it slightly more efficient in terms of profitability.

Main focus going forward:
Increase sales volume in lower-performing countries while learning from both Australia’s volume success and France’s cost efficiency.