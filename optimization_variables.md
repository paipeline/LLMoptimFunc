# Optimization Variables, Constraints, and Functions

## Variables
- [x] **Market Capitalization**: `2296700.17` (from quantitative_data)
- [x] **Sentiment Scores**: Various values from sentiment_analysis (e.g., `0.0`, `-0.05`, `0.4`, etc.)
- [x] **Returns**: Values from the `return` key in sentiment_analysis (to be simulated or derived)
- [x] **Asset Prices**: Historical prices from stock_price_movement (e.g., `176.92`, `176.4`, etc.)
- [ ] **Position Sizes**: Quantity of assets to trade (to be defined)
- [ ] **Risk-Free Rate**: A predefined constant (e.g., `0.02`)

## Constraints
- [x] **Budget Constraint**: Total capital allocated to trades must not exceed available budget.
- [x] **Maximum Drawdown**: The maximum allowable drawdown from the peak portfolio value.
- [x] **Leverage Limits**: Total leverage used in trading must not exceed a specified limit.
- [x] **Liquidity Constraints**: Ensure that trading volumes do not exceed market liquidity.
- [x] **Regulatory Constraints**: Compliance with regulatory requirements, such as short-selling restrictions.

## Optimization Functions
- [ ] **Maximizing Returns**: 
  \[
  \text{Maximize } R_T = \sum_{t=1}^{T} R_t
  \]
- [ ] **Minimizing Risk**: 
  \[
  \text{Minimize } \text{Var}(R) \quad \text{where } \text{Var}(R) = \frac{1}{T-1} \sum_{t=1}^{T} (R_t - \bar{R})^2
  \]
- [ ] **Sharpe Ratio Maximization**: 
  \[
  \text{Maximize } S = \frac{E[R] - R_f}{\sigma_R}
  \]
