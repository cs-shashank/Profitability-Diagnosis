# Findings: Profitability Diagnosis

*Superstore sample dataset (not real company data). 10,194 order rows, 2023–2026.*
*Margin = SUM(profit) / SUM(sales), never an average of row margins.*
*"High discount" = discount above 20% (1,415 rows). "Low discount" = 20% or less
(3,706 rows are exactly 20% and count as low).*

**Data note:** the dataset includes 200 Canadian rows (about 2% of rows, 1.3% of sales and
2.0% of profit; Canada's own margin is 20.11%). All analysis uses all 10,194 rows. US-only
margin would be 12.47% against 12.56% for all rows. Canadian rows carry the same four region
labels (Central 12, East 138, West 50, South 0).

**Status:** association, not proven cause. No cost or price-elasticity data.
Results reconciled across Python, Excel, SQL and Power BI unless marked *(not re-checked)*.

---

## 1. Is the premise true? (sales up, profit lagging)

**No. Profit has not simply lagged sales.**

| Year | Sales | Profit | Margin | Sales YoY | Profit YoY |
|---|---|---|---|---|---|
| 2023 | 494,040.21 | 51,684.30 | 10.46% | | |
| 2024 | 472,993.03 | 62,020.97 | 13.11% | −4.3% | +20.0% |
| 2025 | 613,933.58 | 82,665.20 | 13.46% | +29.8% | +33.3% |
| 2026 | 745,567.53 | 95,926.35 | 12.87% | +21.4% | +16.0% |
| **Total** | **2,326,534.35** | **292,296.81** | **12.56%** | | |

- Profit grew every year. Profit grew faster than sales in 2024 and 2025.
- 2026 is the exception: profit +16.0% vs sales +21.4% (a 5.4-point gap), and margin slipped from 13.46% to 12.87%.
- 1,901 of 10,194 rows (18.6%) are loss-making.

## 2. Where profit is made and lost

**Category**

| Category | Sales | Profit | Margin |
|---|---|---|---|
| Technology | 839,893.28 | 146,543.38 | 17.45% |
| Office Supplies | 731,893.31 | 126,023.44 | 17.22% |
| Furniture | 754,747.76 | 19,730.00 | 2.61% |

**Sub-category.** Three lose money:
- Tables −17,753.21 (−8.53%)
- Bookcases −3,632.07 (−3.15%)
- Supplies −1,171.39 (−2.51%)

The largest profits are Copiers +56,093.94, Phones +45,050.83 and Accessories +41,936.64.
Binders is positive overall (+31,426.10, 15.16%); its losses are in high-discount rows (section 3).

**Region** (all rows)

| Region | Rows | Avg discount | Margin |
|---|---|---|---|
| West | 3,253 | 10.9% | 14.98% |
| East | 2,986 | 14.3% | 13.71% |
| South | 1,620 | 14.7% | 11.93% |
| Central | 2,335 | 24.1% | 7.92% |

## 3. Discounts

**Margin turns negative above a 20% discount** (Python, SQL and Power BI agree):

| Discount band | Margin |
|---|---|
| 0% | 29.56% |
| 1–10% | 16.56% |
| 11–20% | 11.54% |
| 21–30% | −10.06% |
| 31–40% | −19.45% |
| >40% | −77.37% |

**Profit at stake.** Rows above 20% discount are 15.68% of sales but hold a net loss of
**−136,020.69** (1,415 rows). Rows at 20% or less earn +428,317.50.

**The pattern holds within the same sub-category** (low discount → high discount):

| Sub-category | Low | High |
|---|---|---|
| Binders | +40.89% | −106.54% |
| Machines | +29.20% | −38.46% |
| Tables | +11.11% | −33.96% |
| Bookcases | +8.84% | −39.37% |

High-discount rows in these four lose **110,202.73**, which is **81.0%** of all losses on rows above 20%.

**Supplies** loses money (−2.51%) with no rows above 20% discount. Discounts do not explain it.

**By region**

| Region | Rows above 20% | Share of rows | Share of sales above 20% | Margin ≤20% | Margin >20% | Profit on rows >20% |
|---|---|---|---|---|---|---|
| Central | 647 | 27.71% | 25.7% | 24.68% | −40.59% | −52,444.23 |
| East | 479 | 16.04% | 21.4% | 25.29% | −28.88% | −42,681.28 |
| South | 171 | 10.56% | 18.1% | 22.31% | −35.18% | −24,880.48 |
| West | 118 | 3.63% | 2.3% | 17.55% | −93.94% | −16,014.69 |

- **Central is exposed, not inherently weak.** Its average discount is 24.1%, the highest of the four.
  At 20% or less it earns 24.68%. Its 647 high-discount rows lose 52,444 (about 17.9% of net profit).
  If those rows broke even, Central's margin would be about 18.3% (upper bound, not a forecast).
- **West has the best total margin because it rarely discounts heavily** (3.63% of rows, 2.3% of sales).
  Its per-sale loss above 20% is the worst (−93.94%), but on few rows. Its low-discount margin (17.55%)
  is the lowest of the four regions; the cause is not yet explained.

**By category** (share of rows above 20% discount): Furniture 25.22%, Office Supplies 11.24%, Technology 9.17%.
Furniture is weak even at low discount: about 13.4% at 20% or less, against about 25% for the other two
*(Power BI Page 3 and Python)*. So discounts do not explain all of its weakness.

## 4. What changed over time *(from SQL 09 and 10; not re-checked)*

- Share of sales above 20% discount: 21.3% (2023), 13.6% (2024), 14.2% (2025), 14.5% (2026).
- **2024 (sales down, profit up):** high-discount sales fell about 39% with losses flat
  (about −28.2K to −28.5K); low-discount profit rose about 10.6K.
- **2026 margin slip:** high-discount margin fell from −36.10% to −44.23% (loss 31.5K to 47.8K)
  while low-discount margin rose from 21.69% to 22.55%. About 8.8K of profit (about 1.2 margin
  points) was lost versus 2025's high-discount margin (illustrative).
- Loss on rows above 20% grew by about 16,274 from 2025 to 2026. Binders (−8,897) and Tables (−3,260)
  account for about 75% of it. Their average discount was stable (Binders about 74%, Tables about 39%);
  losses rose because more was sold at those discounts (Binders high-discount sales +86%, Tables +65%).
- Machines: high-discount loss flat (about −9.4K in both years); its total fell because
  low-discount profit fell about 5.8K (derived). Cause not explained by the data.
- 2025 to 2026 total profit +13,261: 11 sub-categories gained 28,512 (Copiers +7,297,
  Accessories +6,008), 6 lost 15,251 (Machines −5,738, Tables −5,142, Binders −2,708).

## 5. Sensitivity check *(from SQL 12; not re-checked)*

Removing the 8 most extreme rows (3 Canon copiers, 5 loss-making rows):
- Overall margin 12.56% → 12.92%; profit 292,297 → 292,608.
- Profit still grew every year. The 2026 margin slip persists but is smaller
  (13.66% → 13.31%, against 13.46% → 12.87% with all rows).
- Binders high-discount loss is still much higher in 2026 than 2025 (12,917 vs 6,949); Tables unaffected.
- **Conclusion:** findings hold in direction. The extreme rows exaggerate the 2026 slip by about 40%.

## 6. Profit at stake (illustrative, sales held constant)

Reducing the loss on rows above 20% discount (−136,021) by 25% / 50% / 100% would lift
margin from 12.56% to **14.03% / 15.49% / 18.41%**.
Not a forecast: lower discounts may reduce volume, and there is no cost or elasticity data.

## 7. Open questions

- Why does Supplies lose money with no high discounts?
- Why did Machines' low-discount profit fall in 2026?
- Why is West's low-discount margin (17.55%) the lowest of the four regions?
- Why is Furniture weak even at low discount (product mix, pricing)?

## 8. Limitations

- Sample dataset, not real company data. It includes 200 Canadian rows (about 2% of rows).
- No cost, price-elasticity or customer data.
- Associations, not proven causes.
- Scenario figures are upper bounds with sales held constant.

## 9. Reconciliation status

| Check | Status |
|---|---|
| Totals (sales, profit, margin) | Python = Excel = SQL = Power BI |
| Country split | SQL: US 9,994 + Canada 200 = 10,194 rows; sales and profit add to the totals |
| Yearly margins | Python = Excel = SQL = Power BI |
| Discount bands | Python = Power BI (SQL 04 matched earlier) |
| Region and category margins | Python = SQL = Power BI |
| Region by discount group | Python = SQL (08) = Power BI |
| Region average discount and shares above 20% | SQL 07 = Python |
| SQL 09, 10, 12 figures in sections 4 and 5 | Not re-checked in this session |
| Furniture margin at 20% or less (section 3) | Python = Power BI |