# Data Quality Log

## Source
Tableau sample data, Superstore.xls, sheet "Orders". Sample dataset, not real company data.

## Raw data profile 
- Rows x columns: 10,194 x 21
- Missing values: none in any column
- Order date range: 2023-01-03 to 2026-12-30; ship date range: 2023-01-07 to 2027-01-05
- Total sales: 2,326,534.35 | total profit: 292,296.81 | margin: 12.56%
- Loss-making rows: 1,901 (18.65%), total loss -157,038.93
- Premise test: profit grew every year (2024 +20.00%, 2025 +33.29%, 2026 +16.04%); sales fell in 2024 (-4.26%).
  Only in 2026 did profit growth lag sales growth (16.04% vs 21.44%), with margin 13.46% -> 12.87%.
- Discount bands: margin turns negative between the 11-20% band (11.54%) and the 21-30% band (-10.06%)
- Furniture: 32.4% of sales, 6.7% of profit, 2.61% margin

## Raw data checks 
- No fully duplicated rows; Row ID unique; no ship date before order date
- No leading/trailing spaces; no sales <= 0, quantity <= 0, discount outside 0-1, or profit > sales
- 10,194 rows = 9,994 US + 200 Canada; 59 "states" = 49 US entries (incl. DC) + 10 Canadian provinces
- Canada: 1.26% of sales, 2.02% of profit, 20.11% margin; assigned to East/West/Central
- Postal Code: mixed int/str; 438 US codes lost their leading zero; 200 Canadian codes are 3-character prefixes
- 65 zero-profit rows (not counted as losses)
- 5 most extreme loss rows are Machines/Binders at 50-80% discount; 3 Canon copier rows at 0% discount carry about 20,160 profit. Kept as real events; sensitivity check planned.
- 2 orders with 4 Customer IDs for "Harry Olson"; 1 customer name maps to multiple IDs
- 32 Product IDs map to multiple Product Names; Product Name is used as the product key

## Cleaning actions 
- Columns renamed to snake_case (21 raw columns).
- Postal codes stored as text; the 438 US codes that lost a leading zero were padded to 5 digits. The 200 Canadian codes (3-character prefixes) were left as given. *(confirm against notebook 02)*
- Helper columns added: order_year, order_month, year_month, is_loss, discount_band (26 columns in total).
- No rows removed: duplicates, zero-profit rows (65), extreme rows and the 200 Canadian rows were all kept. *(confirm)*
- Customer ID and Product ID inconsistencies were logged but not changed; Product Name is the product key.
- Validation after cleaning: 10,194 rows, sales 2,326,534.35, profit 292,296.81, 1,901 loss rows, 0 missing values.
- Dates run to 2026-12-30 in the sample file and are used as given; treat the periods as illustrative.