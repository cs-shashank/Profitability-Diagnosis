# KPI Definitions

All KPIs use all 10,194 rows (9,994 US + 200 Canada) unless stated.

| KPI | Definition | Value (all data) |
|---|---|---|
| Sales | SUM(sales) | 2,326,534.35 |
| Profit | SUM(profit) | 292,296.81 |
| **Profit margin** | **SUM(profit) / SUM(sales)**, never an average of row margins | **12.56%** |
| Orders | Distinct count of order_id | 5,111 |
| Average order value (AOV) | Sales / Orders | about 455.20 |
| Loss-making rows | Rows where profit < 0 (65 zero-profit rows are not counted as losses) | 1,901 (18.6%) |
| High discount | discount > 0.20 | 1,415 rows |
| Low discount | discount <= 0.20 (3,706 rows are exactly 0.20) | 8,779 rows |
| High-discount sales share | Sales on rows above 20% discount / total sales | 15.68% |
| High-discount profit | Profit on rows above 20% discount | -136,020.69 |
| YoY % | (This year - last year) / last year, for sales and for profit | see findings.md |
| Growth gap (pts) | (Profit YoY % - Sales YoY %) x 100; positive = profit grew faster than sales | 2026: -5.4 |

## Why margin is weighted
Averaging each row's margin gives 12.22%. Total profit divided by total sales gives 12.56%.
The second is correct because large orders count more than small ones.

## Discount bands
0%, 1-10%, 11-20%, 21-30%, 31-40%, >40% (sorted in that order in Power BI by a band-order column).

## Power BI measures (table `Orders`)
```dax
Total Sales = SUM(Orders[sales])
Total Profit = SUM(Orders[profit])
Profit Margin % = DIVIDE([Total Profit], [Total Sales])
Order Count = DISTINCTCOUNT(Orders[order_id])
AOV = DIVIDE([Total Sales], [Order Count])
Loss Rows = CALCULATE(COUNTROWS(Orders), Orders[profit] < 0)
High Discount Sales Share = DIVIDE(CALCULATE([Total Sales], Orders[discount] > 0.2), [Total Sales])
High Discount Profit = CALCULATE([Total Profit], Orders[discount] > 0.2)
Sales YoY % / Profit YoY % = this year vs last year; blank on the Total row and for 2023
Growth Gap (pts) = ([Profit YoY %] - [Sales YoY %]) * 100
```
Calculated column: `Discount Group = IF(Orders[discount] > 0.2, "Above 20%", "20% or less")`.

## Product key
Product Name is the product key (32 Product IDs map to more than one Product Name).