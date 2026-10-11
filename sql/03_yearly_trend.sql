WITH yearly AS (
    SELECT order_year,
           SUM(sales)  AS sales,
           SUM(profit) AS profit
    FROM orders
    GROUP BY order_year
)
SELECT order_year,
       ROUND(sales, 2)  AS sales,
       ROUND(profit, 2) AS profit,
       ROUND(profit / sales * 100, 2) AS margin_pct,
       ROUND((sales  / LAG(sales)  OVER (ORDER BY order_year) - 1) * 100, 2) AS sales_yoy_pct,
       ROUND((profit / LAG(profit) OVER (ORDER BY order_year) - 1) * 100, 2) AS profit_yoy_pct
FROM yearly
ORDER BY order_year;