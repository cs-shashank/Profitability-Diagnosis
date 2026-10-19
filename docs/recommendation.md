# Recommendation: Control Discounts Above 20%

*Superstore sample dataset (not real company data). 10,194 order rows, 2023–2026.*

## The problem
Profit has not simply lagged sales. Profit grew every year (51,684 → 95,926),
and margin moved between 10.46% (2023) and 13.46% (2025), ending at 12.87% in 2026.
The leak is elsewhere: overall margin is 12.56%, but discounted rows drag it down.

## Evidence
- **Margin turns negative above a 20% discount.** Rows above 20% discount (1,415 rows)
  are 15.68% of sales but hold a net loss of 136,021.
- **The pattern holds within the same sub-category:** Binders +40.89% → −106.54%,
  Machines +29.20% → −38.46%, Tables +11.11% → −33.96%, Bookcases +8.84% → −39.37%.
  High-discount rows in these four lose 110,203, about 81% of all losses on rows above 20%.
- **Central is exposed, not inherently weak.** 27.71% of its rows are above 20% discount
  (West 3.63%). At 20% or less it earns 24.68%; its 647 high-discount rows lose 52,444
  (−40.59%). Central's overall margin is 7.92%, against 11.93% to 14.98% elsewhere.
- **The 2026 slip comes from high-discount sales.** Their margin fell from −36.10% to −44.23%
  while low-discount margin rose (21.69% → 22.55%). Binders and Tables explain about 75%
  of the 16,274 increase in high-discount losses, mainly because more was sold at those discounts.

## Recommendation
1. Require approval for any discount above 20%, starting with Central and with Binders and Tables.
2. Review Furniture separately: its margin (2.61%) is weak even at low discounts,
   so discounting is only part of the story.
3. Investigate what discounts do not explain (Supplies, Machines' low-discount profit, West's low-discount margin).

## Expected impact (illustrative, sales held constant)
Reducing losses on rows above 20% discount by 25% / 50% / 100% would lift
margin from 12.56% to 14.03% / 15.49% / 18.41%.

## Limitations
- Sample dataset; no cost or price-elasticity data, so lower discounts may reduce volume.
  The impact figures are an upper bound, not a forecast.
- The dataset includes 200 Canadian rows (about 2% of rows); all figures use all 10,194 rows.
- Findings show association, not proven cause.
- The 8 most extreme rows exaggerate the 2026 margin slip by about 40%
  (sensitivity check); the direction of the findings holds without them.
- Year-over-year driver figures come from SQL queries 09 to 10 (see findings.md).