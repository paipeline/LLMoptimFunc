# Financial Metrics Plan for Toy Portfolio Optimization

## Introduction

This document outlines the financial metrics and their implications for the toy portfolio optimization process. The goal is to leverage these metrics to enhance the optimization strategy and make informed investment decisions.

## Financial Metrics Overview

1. **Assets**: The list of assets included in the portfolio.
   - Example: `['GOOGL']`

2. **Expected Returns (\( \mu \))**: The expected monthly returns for each asset.
   - Example: `mu = [0.13636363636363635]` (calculated from historical price data).

3. **Covariance Matrix (\( \Sigma \))**: Represents the risk associated with the assets.
   - Example: `Sigma = [[0.0]]` (derived from historical return data).

4. **Sentiment Scores (\( S \))**: Scores derived from sentiment analysis of news articles or social media.
   - Example: `S = [0.0, -0.05, 0.4, 0.4, 0.0, 0.0, 0.0, 0.0, 0.2, -0.15, -0.125, 0.13636363636363635, 0.0, -0.2277777777777778, 0.25, 0.5, 0.7, 0.0, 0.0]`

5. **Risk-Free Rate (\( R_f \))**: The risk-free rate for the period.
   - Example: `R_f = 0.005` (monthly).

6. **Financial Metrics**: Additional metrics to inform the optimization process.
   - **Asset Turnover**: `0.8006`
   - **Current Ratio**: `2.1491`
   - **Debt to Equity**: `0.0463`
   - **Return on Equity**: `0.2952`
   - **Price to Book**: `6.5933`
   - **Price to Earnings**: `23.4305`

## Data Extraction and Calculation

### Timeframe

The data extraction will focus on the previous 12 months to calculate the expected returns and covariance matrix. Monthly data points will be used for optimization at the end of each month.

### Data Sources

1. **Historical Prices**: Fetch historical price data from a financial API (e.g., Alpha Vantage).
2. **Financial Metrics**: Retrieve financial metrics for each asset.
3. **Sentiment Analysis**: Use sentiment analysis tools to derive sentiment scores.

## Conclusion

By integrating these financial metrics into the toy portfolio optimization process, we can enhance the decision-making framework and improve the overall performance of the portfolio.
