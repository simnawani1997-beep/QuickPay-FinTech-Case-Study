# Spreadsheet Analysis Summary

## 1. Data Cleaning Steps
- **Merchant Names:** Standardized using `=PROPER(TRIM())` to ensure consistency across the dataset.
- **Date Formats:** Standardized to `YYYY-MM-DD` to ensure compatibility with SQL and Python tools.
- **Risk Scores:** Cleaned by removing text prefixes ("score:", "risk-") and converting to numeric values. Invalid or missing entries were set to `0` to maintain calculation integrity.
- **Gateway Regions:** Filled missing values by performing a `VLOOKUP` against the `merchant_master.csv` file using the cleaned merchant name as the key.

## 2. Currency Standardization
- Created an `amount_usd` column by joining the `transactions_raw.csv` with `exchange_rates.csv` via `VLOOKUP`.
- All transaction amounts are now standardized into USD for accurate cross-regional reporting.

## 3. Business Logic (Flagging)
- **High-Value Flag:** Implemented a Nested `IF` statement to identify significant transactions based on regional thresholds:
  - APAC: > $5,000
  - EU: > $6,000
  - US: > $7,000
- **High-Risk Flag:** Used an `OR` logic to flag transactions with a risk score ≥ 70 or a status of "Chargeback."

## 4. Key Findings
- Total transaction volume was standardized across three regions.
- High-risk transactions were isolated for the operations team to review, specifically focusing on those with a risk score above 70.
