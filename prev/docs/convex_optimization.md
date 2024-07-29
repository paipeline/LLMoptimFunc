# Convex Optimization Formula

## Introduction

Convex optimization is a subfield of optimization that studies the problem of minimizing convex functions over convex sets. Convex optimization problems are important because they can be solved efficiently and reliably, and they have a wide range of applications in various fields such as finance, engineering, and machine learning.

## Convex Optimization Problem

A convex optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{x}{\text{minimize}}
& & f(x) \\
& \text{subject to}
& & g_i(x) \leq 0, \quad i = 1, \ldots, m \\
& & & h_j(x) = 0, \quad j = 1, \ldots, p
\end{aligned}
\]

where:
- \( f(x) \) is the objective function, which is convex.
- \( g_i(x) \) are the inequality constraint functions, which are convex.
- \( h_j(x) \) are the equality constraint functions, which are affine (i.e., linear).

## Toy Portfolio Optimization

### Introduction

This section presents a simplified example of portfolio optimization using convex optimization principles. The goal is to maximize returns while managing risk.

### Portfolio Optimization Problem

A portfolio optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{maximize}}
& & \mu^T w \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of expected returns.

### Example: Simple Portfolio Optimization

1. **Define Expected Returns**: Assume we have three assets with expected returns:
   - Asset 1: \( \mu_1 = 0.1 \)
   - Asset 2: \( \mu_2 = 0.2 \)
   - Asset 3: \( \mu_3 = 0.15 \)

2. **Formulate the Optimization Problem**:
   - Objective: Maximize returns \( R = 0.1w_1 + 0.2w_2 + 0.15w_3 \)
   - Constraints:
     - \( w_1 + w_2 + w_3 = 1 \)
     - \( w_1, w_2, w_3 \geq 0 \)

3. **Solve the Optimization Problem**: Use a simple optimization method (e.g., gradient ascent) to find the optimal weights.

### Conclusion

This toy example illustrates the basic principles of portfolio optimization using convex optimization techniques. By maximizing expected returns while adhering to constraints, one can make informed investment decisions.

Combining machine learning with convex optimization involves using machine learning models to predict parameters or constraints that are then used in a convex optimization problem. This approach leverages the predictive power of machine learning and the efficiency of convex optimization.

### Step-by-Step Process

1. **Fetching Data from an API**:
   - Use an API to fetch relevant financial data. This data can include historical prices, financial metrics, and sentiment scores.

2. **Predicting Parameters with Machine Learning**:
   - Use machine learning models to predict expected returns (\( \mu \)), risk (covariance matrix \( \Sigma \)), and sentiment scores (\( S \)).
   - For example, regression models can predict expected returns, time series models can predict risk, and sentiment analysis models can predict sentiment scores.

3. **Formulating the Convex Optimization Problem**:
   - Use the predicted parameters in the convex optimization problem to maximize returns or minimize risk.

### Example: Portfolio Optimization

In portfolio optimization, machine learning models can be used to predict expected returns, risk, and sentiment scores. These predictions can then be incorporated into a convex optimization problem to determine the optimal portfolio weights.

1. **Fetching Data from an API**:
   - Fetch data such as historical prices, financial metrics, and sentiment scores from an API.

2. **Predicting Parameters with Machine Learning**:
   - Use regression models to predict expected returns (\( \mu \)).
   - Use time series models to predict risk (covariance matrix \( \Sigma \)).
   - Use sentiment analysis models to predict sentiment scores (\( S \)).

3. **Formulating the Convex Optimization Problem**:
   - Use the predicted parameters in the convex optimization problem to maximize returns or minimize risk.

### Unified Optimization Function

The unified optimization function can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{optimize}}
& & \mu^T w + \alpha \cdot S^T w - \beta \cdot \frac{1}{2} w^T \Sigma w + \delta \cdot \frac{E[\mu^T w + \gamma \cdot S^T w] - R_f}{\sigma_w} \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of predicted expected returns.
- \( S \) is the vector of predicted sentiment scores.
- \( \Sigma \) is the predicted covariance matrix of asset returns.
- \( \alpha \) is a weight that determines the influence of sentiment on returns.
- \( \beta \) is a weight that adjusts the impact of sentiment on risk.
- \( \gamma \) is a weight that reflects the contribution of sentiment to the expected return.
- \( \delta \) is a weight that determines the influence of the Sharpe ratio in the optimization.
- \( R_f \) is the risk-free rate.
- \( \sigma_w \) is the standard deviation of the portfolio returns.
- \( E[\mu^T w + \gamma \cdot S^T w] \) is the expected return adjusted by sentiment.

By adjusting the hyperparameters \( \alpha \), \( \beta \), \( \gamma \), and \( \delta \), traders can tailor the optimization function to focus on maximizing returns, minimizing risk, or maximizing the Sharpe ratio with sentiment analysis.

## Understanding the Strategy

When we refer to the "strategy" in the context of the unified optimization function, we are referring to the specific configuration of hyperparameters (\( \alpha \), \( \beta \), \( \gamma \), and \( \delta \)) that define the optimization approach. These hyperparameters determine the relative importance of different components in the objective function, such as returns, sentiment, risk, and the Sharpe ratio.

By adjusting these hyperparameters, you can tailor the optimization strategy to focus on different aspects of portfolio performance. For example:
- Increasing \( \alpha \) will place more emphasis on sentiment-adjusted returns.
- Increasing \( \beta \) will place more emphasis on minimizing risk.
- Increasing \( \gamma \) will place more emphasis on the contribution of sentiment to the expected return.
- Increasing \( \delta \) will place more emphasis on maximizing the Sharpe ratio.

Thus, the "strategy" is essentially the set of hyperparameters that you choose to optimize the portfolio according to your specific goals and preferences.

## Importance of Data Quality

Data quality is crucial in the context of convex optimization and machine learning. The accuracy and reliability of the predictions made by machine learning models depend heavily on the quality of the input data. Poor quality data can lead to inaccurate predictions, which in turn can result in suboptimal or even detrimental decisions in the optimization process.

### Key Aspects of Data Quality

1. **Accuracy**: The data should accurately represent the real-world scenario it is intended to model. Inaccurate data can mislead the optimization process.

2. **Completeness**: Missing data can lead to biased predictions. It is essential to ensure that the dataset is complete and contains all necessary information.

3. **Consistency**: Data should be consistent across different sources and time periods. Inconsistencies can create confusion and reduce the reliability of the optimization results.

4. **Timeliness**: The data used should be up-to-date. Outdated data can lead to decisions based on irrelevant information.

5. **Relevance**: The data should be relevant to the specific optimization problem being addressed. Irrelevant data can introduce noise and reduce the effectiveness of the optimization.

By ensuring high data quality, practitioners can improve the performance of machine learning models and, consequently, the outcomes of convex optimization problems.

## Data Integration for Convex Optimization

To effectively integrate the fetched data into the convex optimization process, we will follow these steps:

1. **Data Fetching**:
   - Use `src/data_pipeline.py` to fetch historical prices and financial metrics from the Alpha Vantage API.
   - Save the fetched data in the `data` directory.

2. **Machine Learning Predictions**:
   - The `src/data_pipeline.py` will also handle machine learning predictions.
   - Load the fetched data and use machine learning models to predict expected returns, risk (covariance matrix), and sentiment scores.
   - Save the predictions in the `data` directory.

3. **Convex Optimization**:
   - Update `optim.jl` to load the machine learning predictions.
   - Formulate the convex optimization problem using the predicted parameters.
   - Solve the optimization problem to determine the optimal portfolio weights.

### Data Storage

The fetched data and predictions will be stored in the `data` directory as JSON files. This format allows for easy access and manipulation of the data during the optimization process.

### Overview

This proposal outlines the integration of API data fetching, machine learning predictions, and convex optimization. The goal is to create a seamless pipeline that fetches financial data, predicts key parameters using machine learning, and uses these predictions in a convex optimization framework to make informed trading decisions.

### Steps for Integration

1. **Data Fetching**:
   - Use `src/api_extractor.py` to fetch historical prices and financial metrics from the Alpha Vantage API.
   - Save the fetched data in the `data` directory.

2. **Machine Learning Predictions**:
   - Create `src/ml_predictions.py` to handle machine learning predictions.
   - Load the fetched data and use machine learning models to predict expected returns, risk (covariance matrix), and sentiment scores.
   - Save the predictions in the `data` directory.

3. **Convex Optimization**:
   - Update `optim.jl` to load the machine learning predictions.
   - Formulate the convex optimization problem using the predicted parameters.
   - Solve the optimization problem to determine the optimal portfolio weights.

### Detailed Steps

1. **Data Fetching**:
   - Modify `src/api_extractor.py` to include functions for fetching historical prices and financial metrics from the Alpha Vantage API.
   - Save the fetched data as JSON files in the `data` directory.

2. **Machine Learning Predictions**:
   - Create `src/ml_predictions.py` with functions to load the fetched data and predict expected returns, risk, and sentiment scores.
   - Use appropriate machine learning models (e.g., linear regression for returns, time series models for risk, sentiment analysis models for sentiment scores).
   - Save the predictions as JSON files in the `data` directory.

3. **Convex Optimization**:
   - Update `optim.jl` to load the machine learning predictions from the `data` directory.
   - Formulate the convex optimization problem using the predicted parameters.
   - Solve the optimization problem to determine the optimal portfolio weights.

### Example Code

#### src/api_extractor.py
```python
import requests
import json

API_KEY = 'your_alpha_vantage_api_key'

def fetch_historical_prices(symbol, outputsize='compact'):
    url = f'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol={symbol}&outputsize={outputsize}&apikey={API_KEY}'
    response = requests.get(url)
    data = response.json()
    with open(f"data/{symbol}_historical_prices.json", "w") as json_file:
        json.dump(data, json_file)

def fetch_financial_metrics(symbol):
    url = f'https://www.alphavantage.co/query?function=OVERVIEW&symbol={symbol}&apikey={API_KEY}'
    response = requests.get(url)
    data = response.json()
    with open(f"data/{symbol}_financial_metrics.json", "w") as json_file:
        json.dump(data, json_file)

# Example usage
fetch_historical_prices('TSLA')
fetch_financial_metrics('TSLA')
```

#### src/ml_predictions.py
```python
import json
import numpy as np
from sklearn.linear_model import LinearRegression

def load_data(file_path):
    with open(file_path, "r") as file:
        return json.load(file)

def predict_returns(prices):
    # Example: Simple linear regression to predict returns
    X = np.arange(len(prices)).reshape(-1, 1)
    y = np.array(prices)
    model = LinearRegression().fit(X, y)
    return model.predict(X)

def save_predictions(predictions, file_path):
    with open(file_path, "w") as file:
        json.dump(predictions.tolist(), file)

# Example usage
historical_prices = load_data("data/TSLA_historical_prices.json")
predicted_returns = predict_returns(historical_prices)
save_predictions(predicted_returns, "data/predicted_returns.json")
```

#### optim.jl
```julia
using Statistics
using JSON

function load_predictions(file_path)
    open(file_path) do file
        return JSON.parse(file)
    end
end

predicted_returns = load_predictions("data/predicted_returns.json")

# Placeholder data
R_t = [0.01, 0.02, -0.01, 0.03, 0.04]  # Returns at time t
S_t = [0.1, 0.2, -0.1, 0.3, 0.4]       # Sentiment score at time t
R_f = 0.01                             # Risk-free rate
α = 0.5                                # Weight for sentiment in returns
β = 0.5                                # Weight for sentiment in risk
γ = 0.5                                # Weight for sentiment in Sharpe ratio
δ = 0.5                                # Weight for sentiment in optimization

# Unified optimization function with sentiment analysis
function optimize_with_sentiment(R_t, S_t, R_f, α, β, γ, δ)
    E_R = mean(R_t .+ γ .* S_t)
    σ_R = std(R_t .+ γ .* S_t)
    total_returns = sum(R_t .+ α .* S_t)
    risk = var(R_t .+ γ .* S_t)
    sharpe_ratio = (E_R - R_f) / σ_R
    return total_returns - β * risk + δ * sharpe_ratio
end

# Optimization function without sentiment analysis
function optimize_without_sentiment(R_t, R_f, β, δ)
    E_R = mean(R_t)
    σ_R = std(R_t)
    total_returns = sum(R_t)
    risk = var(R_t)
    sharpe_ratio = (E_R - R_f) / σ_R
    return total_returns - β * risk + δ * sharpe_ratio
end

optimized_value_with_sentiment = optimize_with_sentiment(predicted_returns, S_t, R_f, α, β, γ, δ)
println("Optimized Value with Sentiment: ", optimized_value_with_sentiment)
```

### Conclusion

By integrating API data fetching, machine learning predictions, and convex optimization, we can create a powerful pipeline for making informed trading decisions. This approach leverages the strengths of each component to enhance the overall performance and reliability of the trading strategy.

## Convex Optimization with Sentiment Analysis

Incorporating sentiment analysis into convex optimization allows for a more comprehensive approach to portfolio management. By leveraging sentiment scores, we can enhance the optimization process to potentially improve returns and manage risk more effectively.

### Maximizing Returns with Sentiment Analysis

To maximize returns while considering sentiment analysis, we can modify the objective function to include sentiment scores. The optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{maximize}}
& & \mu^T w + \alpha \cdot S^T w \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of expected returns.
- \( S \) is the vector of sentiment scores.
- \( \alpha \) is a weight that determines the influence of sentiment on returns.
- \( \mathbf{1} \) is a vector of ones.

### Minimizing Risk with Sentiment Analysis

To minimize risk while considering sentiment analysis, we can adjust the risk function to account for sentiment scores. The optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{minimize}}
& & \frac{1}{2} w^T \Sigma w - \beta \cdot S^T w \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \Sigma \) is the covariance matrix of asset returns.
- \( S \) is the vector of sentiment scores.
- \( \beta \) is a weight that adjusts the impact of sentiment on risk.
- \( \mathbf{1} \) is a vector of ones.

### Unified Convex Optimization Function with Sentiment Analysis

We can unify the optimization functions into a single function using hyperparameters to define the specific optimization goal. The following unified formula reflects this integration:

\[
\begin{aligned}
& \underset{w}{\text{optimize}}
& & \mu^T w + \alpha \cdot S^T w - \beta \cdot \frac{1}{2} w^T \Sigma w + \delta \cdot \frac{E[\mu^T w + \gamma \cdot S^T w] - R_f}{\sigma_w} \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of expected returns.
- \( S \) is the vector of sentiment scores.
- \( \Sigma \) is the covariance matrix of asset returns.
- \( \alpha \) is a weight that determines the influence of sentiment on returns.
- \( \beta \) is a weight that adjusts the impact of sentiment on risk.
- \( \gamma \) is a weight that reflects the contribution of sentiment to the expected return.
- \( \delta \) is a weight that determines the influence of the Sharpe ratio in the optimization.
- \( R_f \) is the risk-free rate.
- \( \sigma_w \) is the standard deviation of the portfolio returns.
- \( E[\mu^T w + \gamma \cdot S^T w] \) is the expected return adjusted by sentiment.

By adjusting the hyperparameters \( \alpha \), \( \beta \), \( \gamma \), and \( \delta \), traders can tailor the optimization function to focus on maximizing returns, minimizing risk, or maximizing the Sharpe ratio with sentiment analysis.

## Convex Optimization with Sentiment Analysis

Incorporating sentiment analysis into convex optimization allows for a more comprehensive approach to portfolio management. By leveraging sentiment scores, we can enhance the optimization process to potentially improve returns and manage risk more effectively.

### Maximizing Returns with Sentiment Analysis

To maximize returns while considering sentiment analysis, we can modify the objective function to include sentiment scores. The optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{maximize}}
& & \mu^T w + \alpha \cdot S^T w \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of expected returns.
- \( S \) is the vector of sentiment scores.
- \( \alpha \) is a weight that determines the influence of sentiment on returns.
- \( \mathbf{1} \) is a vector of ones.

### Minimizing Risk with Sentiment Analysis

To minimize risk while considering sentiment analysis, we can adjust the risk function to account for sentiment scores. The optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{minimize}}
& & \frac{1}{2} w^T \Sigma w - \beta \cdot S^T w \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \Sigma \) is the covariance matrix of asset returns.
- \( S \) is the vector of sentiment scores.
- \( \beta \) is a weight that adjusts the impact of sentiment on risk.
- \( \mathbf{1} \) is a vector of ones.

### Unified Convex Optimization Function with Sentiment Analysis

We can unify the optimization functions into a single function using hyperparameters to define the specific optimization goal. The following unified formula reflects this integration:

\[
\begin{aligned}
& \underset{w}{\text{optimize}}
& & \mu^T w + \alpha \cdot S^T w - \beta \cdot \frac{1}{2} w^T \Sigma w + \delta \cdot \frac{E[\mu^T w + \gamma \cdot S^T w] - R_f}{\sigma_w} \\
& \text{subject to}
& & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \mu \) is the vector of expected returns.
- \( S \) is the vector of sentiment scores.
- \( \Sigma \) is the covariance matrix of asset returns.
- \( \alpha \) is a weight that determines the influence of sentiment on returns.
- \( \beta \) is a weight that adjusts the impact of sentiment on risk.
- \( \gamma \) is a weight that reflects the contribution of sentiment to the expected return.
- \( \delta \) is a weight that determines the influence of the Sharpe ratio in the optimization.
- \( R_f \) is the risk-free rate.
- \( \sigma_w \) is the standard deviation of the portfolio returns.
- \( E[\mu^T w + \gamma \cdot S^T w] \) is the expected return adjusted by sentiment.

By adjusting the hyperparameters \( \alpha \), \( \beta \), \( \gamma \), and \( \delta \), traders can tailor the optimization function to focus on maximizing returns, minimizing risk, or maximizing the Sharpe ratio with sentiment analysis.
