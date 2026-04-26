# Spreadsheet Analysis Summary

# Task 1: Spreadsheet Analysis & Data Cleaning Report

## 1. Cleaning Steps & Standardization Rules
- **Merchant Name Standardization**: Applied `TRIM()` to remove leading/trailing spaces and `PROPER()` to ensure consistent casing (e.g., "ALPHA MART" and " alpha mart " were both converted to "Alpha Mart").
- **Status Normalization**: Standardized transaction status labels to a uniform "Captured", "Failed", or "Refunded" format to eliminate discrepancies caused by irregular raw entries.
- **Date Formatting**: Converted mixed date formats into a standard `YYYY-MM-DD` string to ensure the data is ready for SQL date-time functions.
- **Geographic Cleanup**: Filled missing values in the `gateway_region` column based on merchant headquarters and standardized the casing to uppercase (e.g., "apac" to "APAC").

## 2. Lookup and Enrichment Logic
- **Currency Conversion**: Used a reference table and logical mapping to convert all transaction amounts into a base currency (USD).
  - Exchange Rates used: **1 INR = 0.0119 USD** and **1 EUR = 1.08 USD**.
- **Risk Categorization**: Enriched the dataset by cross-referencing `clean_status` and `risk_score` to identify transactions that require manual review.

## 3. Formula Samples
- **USD Conversion**: `=IF(G2="INR", F2*0.0119, IF(G2="EUR", F2*1.08, F2))`
- **High_Value_Flag**: `=IF(H2>5000, 1, 0)`
- **High_Risk_Flag**: `=IF(AND(J2="Captured", K2>70), 1, 0)`

## 4. Final Data Summary
- **Total raw rows**: 30
- **Total cleaned rows**: 30
- **Invalid or missing rows handled**: 29 (This includes rows with missing regions, trailing spaces in merchant names, and inconsistent status casing that were all standardized).
- **Top region by GMV**: APAC (Totaling $82,229 in transaction volume).
- **Number of high value transactions**: 7 (Transactions where the amount exceeded $5,000 USD).
- **Number of high risk transactions**: 10 (Transactions marked as "Captured" that also had a Risk Score > 70).
- **Top merchant by captured GMV**: Beta Stores (Leading with 33,141.50 in successful captured volume, followed closely by Alpha Mart).
