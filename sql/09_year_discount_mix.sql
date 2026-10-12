USE profitability;

SELECT order_year,
       CASE WHEN discount > 0.20 THEN 'High (>20%)'
            ELSE 'Low (0-20%)' END AS discount_group,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct,
       ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER (PARTITION BY order_year), 1) AS pct_of_year_sales
FROM orders
GROUP BY order_year, discount_group
ORDER BY order_year, discount_group;