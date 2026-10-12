USE profitability;

SELECT sub_category,
       CASE WHEN discount > 0.20 THEN 'High (>20%)'
            ELSE 'Low (0-20%)' END AS discount_group,
       COUNT(*)                                 AS row_count,
       ROUND(SUM(sales), 2)                     AS sales,
       ROUND(SUM(profit), 2)                    AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
WHERE sub_category IN ('Tables', 'Bookcases', 'Supplies', 'Machines', 'Binders')
GROUP BY sub_category, discount_group
ORDER BY sub_category, discount_group;
