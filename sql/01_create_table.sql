
USE profitability;

SELECT COUNT(*)              AS total_rows,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders;