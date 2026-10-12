SELECT discount_band,
       COUNT(*)                                 AS row_count,
       ROUND(SUM(sales), 2)                     AS sales,
       ROUND(SUM(profit), 2)                    AS profit,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM orders
GROUP BY discount_band
ORDER BY FIELD(discount_band, '0%', '1-10%', '11-20%', '21-30%', '31-40%', '>40%');