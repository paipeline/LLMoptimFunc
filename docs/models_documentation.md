# Models Documentation

This document provides an overview of the optimization models used in the project, including the mathematical formulations and descriptions of each model.

## 1. Optimized Lambda Markowitz Model

The Optimized Lambda Markowitz Model aims to maximize the expected return while minimizing the risk (variance) of the portfolio. The optimization problem can be formulated as follows:

### Objective Function

\[
\text{Maximize } Z = \sum_{i=1}^{n} E[R_i] \cdot w_i - \lambda \cdot \sum_{i=1}^{n} \sum_{j=1}^{n} \sigma_{ij} \cdot w_i \cdot w_j
\]

Where:
- \( Z \) is the objective function to maximize.
- \( E[R_i] \) is the expected return of asset \( i \).
- \( w_i \) is the weight of asset \( i \) in the portfolio.
- \( \lambda \) is the risk aversion coefficient.
- \( \sigma_{ij} \) is the covariance between assets \( i \) and \( j \).

### Constraints

1. The sum of the weights must equal 1:
   \[
   \sum_{i=1}^{n} w_i = 1
   \]

2. The weights must be non-negative:
   \[
   w_i \geq 0 \quad \forall i
   \]

## 2. Classical Markowitz Model

The Classical Markowitz Model also focuses on maximizing expected returns while controlling for risk. The optimization problem is defined as:

### Objective Function

\[
\text{Maximize } Z = \sum_{i=1}^{n} E[R_i] \cdot w_i - \lambda \cdot \sum_{i=1}^{n} w_i^2
\]

Where:
- \( Z \) is the objective function to maximize.
- \( E[R_i] \) is the expected return of asset \( i \).
- \( w_i \) is the weight of asset \( i \) in the portfolio.
- \( \lambda \) is the risk aversion coefficient.

### Constraints

1. The sum of the weights must equal 1:
   \[
   \sum_{i=1}^{n} w_i = 1
   \]

2. The expected return must meet a minimum threshold:
   \[
   \sum_{i=1}^{n} E[R_i] \cdot w_i \geq \lambda
   \]

## 3. Sharpe Ratio Model

The Sharpe Ratio Model aims to maximize the Sharpe ratio, which is defined as the ratio of the expected excess return of the portfolio to its standard deviation. The optimization problem can be formulated as:

### Objective Function

\[
\text{Maximize } S = \frac{\sum_{i=1}^{n} E[R_i] \cdot w_i - r_f}{\sqrt{\sum_{i=1}^{n} \sum_{j=1}^{n} \sigma_{ij} \cdot w_i \cdot w_j}}
\]

Where:
- \( S \) is the Sharpe ratio.
- \( E[R_i] \) is the expected return of asset \( i \).
- \( r_f \) is the risk-free rate.
- \( w_i \) is the weight of asset \( i \) in the portfolio.
- \( \sigma_{ij} \) is the covariance between assets \( i \) and \( j \).

### Constraints

1. The sum of the weights must equal 1:
   \[
   \sum_{i=1}^{n} w_i = 1
   \]

2. The weights must be non-negative:
   \[
   w_i \geq 0 \quad \forall i
   \]

## Conclusion

This document outlines the mathematical formulations and constraints for the optimization models used in this project. Each model provides a different approach to portfolio optimization, allowing for flexibility in investment strategies based on risk preferences.
