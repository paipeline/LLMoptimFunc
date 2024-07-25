# Quadratic Portfolio Optimization Plan

## Objective
To maximize the expected return of the portfolio while minimizing risk through diversification.

## Variables

### 1. Asset Returns
- **Expected Returns**: The anticipated return for each asset in the portfolio.

### 2. Asset Weights
- **Weights**: The proportion of the total portfolio value allocated to each asset.

### 3. Covariance Matrix
- **Covariance**: A matrix representing the covariance between the returns of different assets.

### 4. Risk Metrics
- **Volatility**: The standard deviation of asset returns, representing risk.
- **Beta**: A measure of the asset's risk in relation to the market.

### 5. Financial Metrics
- **Price to Earnings (P/E) Ratio**: A valuation ratio calculated by dividing the market price per share by the earnings per share.
- **Price to Book (P/B) Ratio**: A ratio used to compare a company's current market price to its book value.
- **Return on Equity (ROE)**: A measure of financial performance calculated by dividing net income by shareholders' equity.

### 6. Constraints
- **Budget Constraint**: The total investment must equal the available capital.
- **Weight Constraints**: The sum of asset weights must equal 1 (100% of the portfolio).

## Conclusion
Using these variables, we can formulate a quadratic optimization problem to find the optimal asset weights that maximize returns while minimizing risk.
## Optimization Function

To optimize the portfolio, we can define a function that takes the following parameters:

- **Market Capitalization**: 2296700.17 (in millions)
- **Asset Turnover**: 0.8006
- **Current Ratio**: 2.1491
- **Debt to Equity**: 0.0463
- **Return on Equity**: 0.2952
- **Price to Book**: 6.5933
- **Price to Earnings**: 23.4305
- **Volatility**: 0.2157

### Function Definition

```python
def optimize_portfolio(market_cap, asset_turnover, current_ratio, debt_to_equity, return_on_equity, price_to_book, price_to_earnings, volatility):
    # Placeholder for optimization logic
    optimal_weights = {}  # This will hold the optimal weights for each asset
    # Implement optimization logic here
    return optimal_weights

# Example usage
optimal_portfolio = optimize_portfolio(
    market_cap=2296700.17,
    asset_turnover=0.8006,
    current_ratio=2.1491,
    debt_to_equity=0.0463,
    return_on_equity=0.2952,
    price_to_book=6.5933,
    price_to_earnings=23.4305,
    volatility=0.21572461094858805
)
```
