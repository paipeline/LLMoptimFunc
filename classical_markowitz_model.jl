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

# Define tradeoff variable
lambda = 0.5  # Adjust this value as needed

# Create the optimization model
model = Model(Gurobi.Optimizer)

# Define variables for asset percentages
@variable(model, percentages[1:size(expected_returns, 1)] >= 0)

# Define the objective function (maximize expected return)
@objective(model, Max, sum(expected_returns[i] * percentages[i] for i in 1:length(expected_returns)) - 
    lambda * sum(percentages[i]^2 for i in 1:length(percentages)))

# Define the initial investment amount
initial_investment = 10000.0  # Adjust this value as needed

# Define the budget as a percentage
budget = 1.0  # Total allocation must equal 100%

# Constraint: sum of weights must equal the budget
@constraint(model, sum(percentages) == 1.0)  # Total allocation must equal 100%

# Define the expected return constraint
@constraint(model, sum(expected_returns[i] * percentages[i] for i in 1:length(expected_returns)) >= lambda)

# Solve the optimization problem
optimize!(model)

# Get the maximized value
maximized_value = objective_value(model)

# Check if weights are non-negative
if any(value.(percentages) .< 0)
    println("Warning: Some asset weights are negative.")
end

# Print the sum of weights
println("Sum of Asset Weights: ", sum(value.(percentages)))

# Return the maximized value
println("Maximized Value: ", maximized_value)
println("Optimized Asset Percentages (Dollar Amounts):")
for i in 1:length(percentages)
    println("Asset ", i, " (", expected_returns_df.Ticker[i], "): \$", value(percentages[i]) * initial_investment)
end

# Check if the sum of weights is approximately equal to 1
if abs(sum(value.(percentages)) - 1) < 1e-5
    println("The sum of asset percentages is approximately equal to 1.")
else
    println("Warning: The sum of asset weights is not equal to 1.")
end

println("\nExplanation:")
println("The maximized return represents the highest expected return achievable given the constraints of the model.")
println("This value is crucial for investors as it indicates the optimal allocation of funds across different assets")
println("to achieve the best possible return while managing risk.")
