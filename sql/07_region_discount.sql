USE profitability;

SELECT region,
       COUNT(*)                                          AS row_count,
       ROUND(AVG(discount) * 100, 1)                     AS avg_discount_pct,
       ROUND(100 * SUM(discount > 0.20) / COUNT(*), 1)   AS pct_rows_over_20,
       ROUND(100 * SUM(CASE WHEN discount > 0.20 THEN sales END) / SUM(sales), 1) AS pct_sales_over_20,
       ROUND(SUM(profit) / SUM(sales) * 100, 2)          AS margin_pct
FROM orders
WHERE country_region = 'United States'
GROUP BY region
ORDER BY margin_pct;
