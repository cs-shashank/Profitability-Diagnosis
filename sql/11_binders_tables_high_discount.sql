USE profitability;

SELECT sub_category,
       order_year,
       COUNT(*)                                 AS row_count,
       ROUND(AVG(discount) * 100, 1)            AS avg_discount_pct,
       ROUND(SUM(sales), 2)                     AS sales,
       ROUND(SUM(profit), 2)                    AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
WHERE sub_category IN ('Binders', 'Tables') AND discount > 0.20
GROUP BY sub_category, order_year
ORDER BY sub_category, order_year;
