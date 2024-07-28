using CSV
using DataFrames
using JuMP
using Gurobi

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv") |> DataFrame

# Extract expected returns and covariance matrix
expected_returns = expected_returns_df.Expected_Returns
covariance_matrix = Matrix(covariance_matrix_df)

# Create the Sharpe Ratio optimization model
sharpe_model = Model(Gurobi.Optimizer)

# Define variables for asset percentages
@variable(sharpe_model, sharpe_percentages[1:size(expected_returns, 1)] >= 0)

# Define the risk-free rate
risk_free_rate = 0.01  # Adjust this value as needed

# Calculate excess returns
excess_returns = expected_returns .- risk_free_rate

# Define the objective function (maximize Sharpe Ratio)
@objective(sharpe_model, Max, sum(excess_returns[i] * sharpe_percentages[i] for i in 1:length(excess_returns)) / 
    sqrt(sum(covariance_matrix[i, j] * sharpe_percentages[i] * sharpe_percentages[j] for i in 1:length(sharpe_percentages), j in 1:length(sharpe_percentages))))

# Define the budget as a percentage
budget = 1.0  # Total allocation must equal 100%

# Constraint: sum of weights must equal the budget
@constraint(sharpe_model, sum(sharpe_percentages) == 1.0)  # Total allocation must equal 100%

# Constraint: expected return must be greater than or equal to zero
@constraint(sharpe_model, sum(excess_returns[i] * sharpe_percentages[i] for i in 1:length(excess_returns)) >= 0)

# Solve the optimization problem
optimize!(sharpe_model)

# Get the maximized Sharpe Ratio value
maximized_sharpe_value = objective_value(sharpe_model)

# Print the optimized asset percentages for Sharpe Ratio
println("Optimized Asset Percentages for Sharpe Ratio (Dollar Amounts):")
for i in 1:length(sharpe_percentages)
    println("Asset ", i, " (", expected_returns_df.Ticker[i], "): \$", value(sharpe_percentages[i]) * 10000.0)  # Assuming initial investment is 10000
end

# Print the maximized Sharpe Ratio value
println("Maximized Sharpe Ratio: ", maximized_sharpe_value)

println("\nExplanation:")
println("The maximized Sharpe Ratio represents the highest expected return per unit of risk.")
println("This value is crucial for investors as it indicates the optimal allocation of funds across different assets")
println("to achieve the best possible return while managing risk.")
