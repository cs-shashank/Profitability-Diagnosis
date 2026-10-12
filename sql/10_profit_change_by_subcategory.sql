USE profitability;

-- All rows
SELECT sub_category,
       ROUND(SUM(CASE WHEN order_year = 2025 THEN profit END), 2) AS profit_2025,
       ROUND(SUM(CASE WHEN order_year = 2026 THEN profit END), 2) AS profit_2026,
       ROUND(SUM(CASE WHEN order_year = 2026 THEN profit END)
           - SUM(CASE WHEN order_year = 2025 THEN profit END), 2) AS profit_change
FROM orders
WHERE order_year IN (2025, 2026)
GROUP BY sub_category
ORDER BY profit_change;

-- Only rows with discount above 20%
SELECT sub_category,
       ROUND(SUM(CASE WHEN order_year = 2025 THEN profit END), 2) AS profit_2025,
       ROUND(SUM(CASE WHEN order_year = 2026 THEN profit END), 2) AS profit_2026,
       ROUND(SUM(CASE WHEN order_year = 2026 THEN profit END)
           - SUM(CASE WHEN order_year = 2025 THEN profit END), 2) AS profit_change
FROM orders
WHERE order_year IN (2025, 2026) AND discount > 0.20
GROUP BY sub_category
ORDER BY profit_change;