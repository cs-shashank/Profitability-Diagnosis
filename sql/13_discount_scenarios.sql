USE profitability;

WITH base AS (
    SELECT SUM(sales)  AS total_sales,
           SUM(profit) AS total_profit,
           SUM(CASE WHEN discount > 0.20 THEN profit ELSE 0 END) AS high_profit
    FROM orders
)
SELECT 'Current' AS scenario,
       ROUND(total_profit, 2) AS profit,
       ROUND(total_profit / total_sales * 100, 2) AS margin_pct
FROM base
UNION ALL
SELECT 'High-discount loss reduced by 25%',
       ROUND(total_profit - 0.25 * high_profit, 2),
       ROUND((total_profit - 0.25 * high_profit) / total_sales * 100, 2)
FROM base
UNION ALL
SELECT 'High-discount loss reduced by 50%',
       ROUND(total_profit - 0.50 * high_profit, 2),
       ROUND((total_profit - 0.50 * high_profit) / total_sales * 100, 2)
FROM base
UNION ALL
SELECT 'High-discount rows break even',
       ROUND(total_profit - 1.00 * high_profit, 2),
       ROUND((total_profit - 1.00 * high_profit) / total_sales * 100, 2)
FROM base;