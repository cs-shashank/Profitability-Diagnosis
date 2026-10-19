# Reconciliation

Each figure is computed independently in several tools. "-" means not computed in that tool.

| Check | Python | Excel | SQL | Power BI |
|---|---|---|---|---|
| Rows | 10,194 | 10,194 | 10,194 | - |
| Sales | 2,326,534.35 | 2,326,534.35 | 2,326,534.35 | 2,326,534.35 |
| Profit | 292,296.81 | 292,296.81 | 292,296.81 | 292,296.81 |
| Margin | 12.56% | 12.56% | 12.56% | 12.56% |
| Loss rows | 1,901 | - | - | 1,901 |
| Yearly margin 2023 / 24 / 25 / 26 | 10.46 / 13.11 / 13.46 / 12.87 | same | same | same |
| Discount bands (0% to >40%) | 29.56, 16.56, 11.54, -10.06, -19.45, -77.37 | confirm | same | same |
| Region margin (Central / South / East / West) | 7.92, 11.93, 13.71, 14.98 | confirm | same | same |
| Rows above 20% discount | 1,415 | - | 1,415 | - |
| Profit on rows above 20% | -136,020.69 | - | about -136,021 | -136,020.69 |
| Region by discount group (Central high: rows, profit) | 647, -52,444.23 | - | 647, -52,444.23 | -40.59% margin |
| Country split | US 9,994 + Canada 200 | - | same | - |

## Issues found and how they were resolved
1. **Margin method.** Averaging row margins gives 12.22%; total profit / total sales gives 12.56%. The weighted method is used everywhere.
2. **Excel pivot total was short by one row** (2,326,531.33 against 2,326,534.35). The source table was reloaded and the pivot then matched.
3. **SQL 07 and 08 excluded Canada.** They had `WHERE country_region = 'United States'`, so their region figures (e.g. Central 643 high-discount rows) differed from Python and Power BI (647). Found by comparing tools; the filter was removed, and all four tools agree on all rows. The other region queries never had the filter.