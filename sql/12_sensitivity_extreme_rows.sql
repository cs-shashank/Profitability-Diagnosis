USE profitability;
/*
CREATE OR REPLACE VIEW orders_trimmed AS
SELECT * FROM (
    SELECT o.*,
           ROW_NUMBER() OVER (ORDER BY profit DESC) AS rn_high,
           ROW_NUMBER() OVER (ORDER BY profit ASC)  AS rn_low
    FROM orders o
) r
WHERE rn_high > 3 AND rn_low > 5;
*/
/*
SELECT 'All rows' AS version,
       COUNT(*) AS row_count,
       ROUND(SUM(sales), 2) AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
UNION ALL
SELECT 'Without 8 extreme rows',
       COUNT(*),
       ROUND(SUM(sales), 2),
       ROUND(SUM(profit), 2),
       ROUND(SUM(profit) / SUM(sales) * 100, 2)
FROM orders_trimmed;
*/
/*
SELECT order_year,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders_trimmed
GROUP BY order_year
ORDER BY order_year;
*/
SELECT sub_category, order_year,
       COUNT(*) AS row_count,
       ROUND(SUM(sales), 2)  AS sales,
       ROUND(SUM(profit), 2) AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders_trimmed
WHERE sub_category IN ('Binders', 'Tables') AND discount > 0.20
GROUP BY sub_category, order_year
ORDER BY sub_category, order_year;