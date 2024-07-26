# Classical Markowitz Model Documentation

## Data Requirements
To perform the classical Markowitz model optimization, the following data is required:

1. **Expected Returns**: A vector of expected returns for each asset in the portfolio. This can be estimated using historical data or predictive models.
2. **Covariance Matrix**: A matrix that represents the covariance between the returns of the assets. This quantifies how the returns of different assets move together.
3. **Number of Assets**: The total number of assets in the portfolio, denoted as \( n \).
4. **Risk Aversion Coefficient**: A scalar value representing the investor's risk tolerance, denoted as \( \rho \).
5. **Budget Constraint**: A constraint ensuring that the total allocation of funds equals 1.

## Variables
In the context of the classical Markowitz model, the following variables are defined:

- \( x[i] \): The allocation of funds to asset \( i \) in the portfolio, where \( x[i] \geq 0 \).
- \( \Sigma \): The covariance matrix of asset returns.
- \( rr \): A vector of expected returns for each asset.
- \( \rho \): The risk aversion coefficient.

## Optimization Model Mathematical Formulation
The classical Markowitz model can be formulated as a quadratic optimization problem. The objective is to minimize the portfolio variance while achieving a minimum expected return. The mathematical formulation is as follows:

### Objective Function
Minimize:
\[
\text{Minimize } \frac{1}{2} x^T \Sigma x
\]

### Subject to Constraints
1. Expected return constraint:
\[
E(R) = rr^T x \geq \rho
\]
2. Budget constraint:
\[
\sum_{i=1}^{n} x[i] = 1
\]
3. Non-negativity constraint:
\[
x[i] \geq 0 \quad \forall i
\]

This formulation allows for the optimization of asset allocations in a way that balances risk and return according to the investor's preferences.
