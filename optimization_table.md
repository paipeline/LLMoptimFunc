# Optimization Variables, Constraints, and Functions

## Variables

| Variable Type         | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Decision Variables     | Trading Signals (buy/sell/hold), Position Sizes, Thresholds and Limits     |
| State Variables        | Asset Prices, Market Indicators, Portfolio Values                          |

## Constraints

| Constraint Type       | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Budget Constraints     | Total capital allocated to trades does not exceed available budget          |
| Risk Management        | Maximum Drawdown, Leverage Limits                                           |
| Market Constraints     | Liquidity Constraints, ensuring trading volumes do not exceed market liquidity |
| Regulatory Constraints  | Compliance with regulatory requirements                                      |

## Optimization Functions

| Function Type         | Objective                                                                     |
|-----------------------|------------------------------------------------------------------------------|
| Maximizing Returns     | \(\text{Maximize } R_T = \sum_{t=1}^{T} R_t\)                               |
| Minimizing Risk        | \(\text{Minimize } \text{Var}(R) \quad \text{where } \text{Var}(R) = \frac{1}{T-1} \sum_{t=1}^{T} (R_t - \bar{R})^2\) |
| Sharpe Ratio Maximization | \(\text{Maximize } S = \frac{E[R] - R_f}{\sigma_R}\)                     |
| Custom Objectives      | \(\text{Maximize } \text{Custom Objective}\)                               |
