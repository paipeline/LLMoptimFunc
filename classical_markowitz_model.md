# Classical Markowitz Model Documentation

## Data Requirements
To perform the classical Markowitz model optimization, the following data is required:

1. **Expected Returns**: A vector of expected returns for each asset in the portfolio. This can be estimated using historical data or predictive models.
2. **Covariance Matrix**: A matrix that represents the covariance between the returns of the assets. This quantifies how the returns of different assets move together.
3. **Number of Assets**: The total number of assets in the portfolio, denoted as \( n \).
4. **Risk Aversion Coefficient**: A scalar value representing the investor's risk tolerance, denoted as \( \rho \). This coefficient influences the trade-off between risk and return in the optimization process.
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

## Maximized Value and Its Application

The `maximized_value` represents the optimal expected return of the investment portfolio based on the selected asset allocations, risk aversion coefficient, and budget constraint. It is calculated after the optimization process and reflects the best possible return that can be achieved given the constraints of the model.

### Real Application Example and Implications of Maximized Value

The `maximized_value` is crucial for investors as it indicates the optimal expected return based on the selected asset allocations. In the example of Alice, the `maximized_value` of $1,200 represents the highest return she can expect from her investment of $10,000, given her risk tolerance and the constraints of the model.

This value has significant real-world implications:

1. **Investment Decision-Making**: Knowing the `maximized_value` helps investors make informed decisions about where to allocate their funds. It provides a benchmark for evaluating the performance of their investments.

2. **Risk Management**: The `maximized_value` reflects the trade-off between risk and return. Investors can adjust their risk aversion coefficient to see how it affects the expected return, allowing them to align their investment strategy with their risk tolerance.

3. **Performance Evaluation**: After the investment period, investors can compare the actual returns with the `maximized_value` to assess the effectiveness of their investment strategy. This comparison can guide future investment decisions.

4. **Portfolio Optimization**: The `maximized_value` serves as a target for portfolio optimization. Investors can use it to refine their asset allocation strategies and improve their overall investment performance.

In summary, the `maximized_value` is not just a theoretical output; it has practical implications for investors in terms of decision-making, risk management, performance evaluation, and portfolio optimization.

For instance, consider an investor named Alice who wants to invest in a portfolio of stocks. She has the following expected returns for three stocks:

- Stock A: 8%
- Stock B: 5%
- Stock C: 10%

Alice has a risk aversion coefficient of 0.5, indicating her moderate risk tolerance. She wants to allocate her total investment of $10,000 among these stocks.

After running the classical Markowitz model, the `maximized_value` might output a value of $1,200. This means that, based on the optimal allocation of her investment, Alice can expect to earn a return of $1,200 from her $10,000 investment.

1. **Initial Investment**: Alice decides to invest $10,000 based on the model's output.
2. **Optimal Allocation**: The model suggests she should allocate:
   - 50% to Stock A ($5,000)
   - 30% to Stock B ($3,000)
   - 20% to Stock C ($2,000)
3. **Expected Returns**:
   - Stock A: $5,000 * 8% = $400
   - Stock B: $3,000 * 5% = $150
   - Stock C: $2,000 * 10% = $200
4. **Total Expected Return**: $400 + $150 + $200 = $750

After a year, if Alice decides to sell her stocks, she can expect to receive a total return of $750 based on the optimal allocation suggested by the model.

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
The classical Markowitz model can be formulated as a quadratic optimization problem. The objective is to minimize the portfolio variance while achieving a minimum expected return. The mathematical formulation is as follows:

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
