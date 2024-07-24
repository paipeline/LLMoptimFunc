# Combined Optimization Formula

## Introduction

This document presents a combined optimization formula that integrates maximizing returns, minimizing risk, and maximizing the Sharpe ratio into a single objective function.

## Optimization Functions

1. **Maximizing Returns with Market Capitalization**: 
   \[
   \text{Maximize } R_T = \sum_{t=1}^{T} (R_t \cdot \text{Market Cap})
   \]

2. **Minimizing Risk with Volatility**: 
   \[
   \text{Minimize } \text{Var}(R) \quad \text{where } \text{Var}(R) = \frac{1}{T-1} \sum_{t=1}^{T} (R_t - \bar{R})^2 + \text{Volatility}
   \]

3. **Sharpe Ratio Maximization with Sentiment**: 
   \[
   \text{Maximize } S = \frac{E[R + \alpha \cdot S] - R_f}{\sigma_R}
   \]

4. **Custom Objectives**: 
   \[
   \text{Maximize } \text{Custom Objective}
   \]

## Variables

1. **Decision Variables**
   - **Trading Signals**: Binary variables indicating whether to buy, sell, or hold an asset.
   - **Position Sizes**: The quantity of each asset to trade.
   - **Thresholds and Limits**: Parameters for technical indicators and risk management.

2. **State Variables**
   - **Asset Prices**: Current and historical prices of the assets.
   - **Market Indicators**: Technical indicators derived from price and volume data.
   - **Portfolio Values**: Total value of the portfolio at any given time.

## Constraints

1. **Budget Constraints**
   - Total capital allocated to trades must not exceed the available budget:
   \[
   \sum_{i=1}^{N} P_i \cdot Q_i \leq C
   \]
   where \( P_i \) is the price of asset \( i \), \( Q_i \) is the quantity of asset \( i \), and \( C \) is the total capital.

2. **Risk Management Constraints**
   - **Leverage Limits**: The total leverage used in trading must not exceed a specified limit:
   \[
   \sum_{i=1}^{N} \frac{P_i \cdot Q_i}{E} \leq L
   \]
   where \( E \) is the equity and \( L \) is the maximum leverage.

3. **Market Constraints**
   - **Liquidity Constraints**: Ensure that trading volumes do not exceed market liquidity:
   \[
   Q_i \leq L_i
   \]
   where \( L_i \) is the available liquidity for asset \( i \).

4. **Regulatory Constraints**
   - Compliance with regulatory requirements, such as short-selling restrictions:
   \[
   S_i \geq 0
   \]
   where \( S_i \) is the short position for asset \( i \).

## Optimization Functions

The combined optimization objective can be expressed as:

\[
\text{Maximize } Z = \alpha \cdot R_T - \beta \cdot \text{Var}(R) + \gamma \cdot S
\]

Where:
- \( Z \) is the overall objective to maximize.
- \( R_T = \sum_{t=1}^{T} R_t \) is the total return.
- \( \text{Var}(R) = \frac{1}{T-1} \sum_{t=1}^{T} (R_t - \bar{R})^2 \) is the variance of returns (risk).
- \( S = \frac{E[R] - R_f}{\sigma_R} \) is the Sharpe ratio.
- \( \alpha, \beta, \gamma \) are weights that determine the importance of each component in the optimization process.

This formula allows traders to balance their focus on returns, risk, and risk-adjusted performance based on their specific trading goals and market conditions.
