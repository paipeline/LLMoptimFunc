# Classical Markowitz Model Documentation

## Data Requirements
To perform the classical Markowitz model optimization, the following data is required:

1. **Expected Returns**: A vector of expected returns for each asset in the portfolio. This can be estimated using historical data or predictive models.
2. **Covariance Matrix**: A matrix that represents the covariance between the returns of the assets. This quantifies how the returns of different assets move together.
3. **Number of Assets**: The total number of assets in the portfolio, denoted as \( n \).
4. **Tradeoff Variable**: A scalar value representing the investor's tradeoff between risk and return, denoted as \( \lambda \). This variable influences the trade-off in the optimization process.
5. **Budget Constraint**: A constraint ensuring that the total allocation of funds equals 1.

## Budget Constraint Explanation
The budget constraint is a critical component of the optimization model. It ensures that the total allocation of funds across all assets equals the specified budget. In this model, the budget is set to 1, representing 100% of the portfolio. This constraint allows the optimization process to focus on maximizing returns while adhering to the investor's total available capital.

## Variables

### Expected Returns Calculation
The expected returns for each asset are calculated as the average return over all previous dates, derived from the historical return data. This provides a single value representing the anticipated performance of each asset based on historical data.
In the context of the classical Markowitz model, the following variables are defined:

- \( x[i] \): The allocation of funds to asset \( i \) in the portfolio, where \( x[i] \geq 0 \).
- \( \Sigma \): The covariance matrix of asset returns, calculated from the historical return data to quantify how the returns of different assets move together.
- \( rr \): A vector of expected returns for each asset.
- \( \rho \): The risk aversion coefficient.

## Tuning the Tradeoff Variable (λ)

The tradeoff variable \( \lambda \) is a free hyperparameter that needs to be tuned to achieve optimal results in the classical Markowitz model. Tuning can be performed using various machine learning methods, including:

1. **Grid Search**: This method involves defining a range of values for \( \lambda \) and evaluating the model's performance for each value. The optimal \( \lambda \) is selected based on the best performance metric.

2. **Bayesian Optimization**: This is a more sophisticated approach that builds a probabilistic model of the function mapping \( \lambda \) values to performance metrics. It iteratively selects \( \lambda \) values to evaluate, balancing exploration and exploitation to find the optimal value efficiently.

By employing these tuning methods, investors can determine the most suitable \( \lambda \) that aligns with their risk-return preferences, leading to better investment decisions.

The classical Markowitz model addresses the tradeoff between maximizing expected return and minimizing portfolio variance. Investors seek to achieve the highest possible return while managing the associated risks. This balance is crucial for effective investment decision-making.

The `maximized_value` represents the optimal expected return based on the selected asset allocations, while the variance quantifies the risk involved. By adjusting the risk aversion coefficient, investors can influence the tradeoff, allowing them to align their investment strategies with their risk tolerance.

### Implications of Maximized Value

The `maximized_value` is essential for understanding the optimal allocation of funds across different assets. It provides insights into how to achieve the best possible return while managing risk effectively.

### Covariance Matrix Output
The covariance matrix is saved in a CSV file named `covariance_matrix.csv`. It is structured as follows:

1. The first row contains the tickers of the assets.
2. The first column also contains the tickers.
3. The intersection of the rows and columns contains the covariance values.

The expected output format in `covariance_matrix.csv` looks like this:

```
,Ticker1,Ticker2,Ticker3,...
Ticker1,cov(Ticker1,Ticker1),cov(Ticker1,Ticker2),cov(Ticker1,Ticker3),...
Ticker2,cov(Ticker2,Ticker1),cov(Ticker2,Ticker2),cov(Ticker2,Ticker3),...
Ticker3,cov(Ticker3,Ticker1),cov(Ticker3,Ticker2),cov(Ticker3,Ticker3),...
...
```
The classical Markowitz model can be formulated as a quadratic optimization problem. The objective is to maximize expected return while minimizing portfolio variance. The mathematical formulation is as follows:

### Quadratic Model Explanation
The classical Markowitz model is a quadratic optimization problem where the objective is to minimize the portfolio variance while achieving a specified expected return. The quadratic nature arises from the formulation of the portfolio variance, which is expressed as:

\[
\text{Variance} = x^T \Sigma x
\]

where:
- \( x \) is the vector of asset weights in the portfolio.
- \( \Sigma \) is the covariance matrix of asset returns.

The objective function is defined as:

### Objective Function
Maximize:
\[
\text{Maximize } E(R) - \lambda x^T \Sigma x
\]

### Subject to Constraints
1. Expected return constraint:
\[
E(R) = rr^T x \geq \lambda
\]
2. Budget constraint:
\[
\sum_{i=1}^{n} x[i] = 1
\]
3. Expected return constraint:
\[
E(R) = rr^T x \geq \lambda
\]
### Explanation of Constraints

1. **Budget Constraint**: This constraint ensures that the total allocation of funds across all assets equals the specified budget. In this model, the budget is set to 1, representing 100% of the portfolio. This constraint allows the optimization process to focus on maximizing returns while adhering to the investor's total available capital.

2. **Expected Return Constraint**: This constraint is necessary to ensure that the portfolio meets a minimum expected return level, which is crucial for investors who have specific return targets. By enforcing this constraint, the optimization process can identify asset allocations that not only maximize returns but also satisfy the investor's risk-return profile. It helps in aligning the portfolio with the investor's financial goals and risk tolerance.

3. **Non-negativity Constraint**: This constraint ensures that no short selling occurs in the portfolio, meaning that all asset allocations must be non-negative. This is important for investors who wish to avoid the risks associated with short selling.
\]

This formulation allows for the optimization of asset allocations in a way that balances maximizing returns while minimizing risks according to the investor's preferences.
