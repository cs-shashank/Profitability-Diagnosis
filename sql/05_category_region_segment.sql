USE profitability;

SELECT category, sub_category,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
GROUP BY category, sub_category
ORDER BY category, margin_pct;

SELECT region,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
GROUP BY region
ORDER BY margin_pct;

SELECT segment,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
GROUP BY segment
ORDER BY margin_pct;