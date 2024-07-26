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

# Define risk aversion coefficient
risk_aversion_coefficient = 0.5  # Adjust this value as needed

# Create the optimization model
model = Model(Gurobi.Optimizer)

# Define variables for asset weights
@variable(model, weights[1:size(expected_returns, 1)] >= 0)

# Define the objective function (maximize expected return)
@objective(model, Max, sum(expected_returns[i] * weights[i] for i in 1:length(expected_returns)) - 
    risk_aversion_coefficient * sum(weights[i]^2 for i in 1:length(weights)))

# Fake constraint: sum of weights must equal 1
@constraint(model, sum(weights) == 1)

# Solve the optimization problem
optimize!(model)

# Get the maximized value
maximized_value = objective_value(model)

# Check if weights are non-negative
if any(value.(weights) .< 0)
    println("Warning: Some asset weights are negative.")
end

# Print the sum of weights
println("Sum of Asset Weights: ", sum(value.(weights)))

# Return the maximized value
println("Maximized Value: ", maximized_value)
println("Optimized Asset Weights:")
for i in 1:length(weights)
    println("Asset ", i, " (", expected_returns_df.Ticker[i], "): ", value.(weights[i]))
end

# Check if the sum of weights is approximately equal to 1
if abs(sum(value.(weights)) - 1) < 1e-5
    println("The sum of asset weights is approximately equal to 1.")
else
    println("Warning: The sum of asset weights is not equal to 1.")
end

println("\nExplanation:")
println("The maximized return represents the highest expected return achievable given the constraints of the model.")
println("This value is crucial for investors as it indicates the optimal allocation of funds across different assets")
println("to achieve the best possible return while managing risk.")
