using CSV
using DataFrames
using JuMP
using Gurobi

# Define file paths
expected_returns_path = "data/expected_returns.csv"
covariance_matrix_path = "../data/covariance_matrix.csv"

# Check if files exist
if !isfile(expected_returns_path)
    error("Expected returns file not found: $expected_returns_path")
end

if !isfile(covariance_matrix_path)
    error("Covariance matrix file not found: $covariance_matrix_path")
end

# Load expected returns and covariance matrix
expected_returns_df = CSV.File(expected_returns_path) |> DataFrame
covariance_matrix_df = CSV.File(covariance_matrix_path) |> DataFrame

# Extract expected returns and covariance matrix
expected_returns = expected_returns_df.Expected_Returns
covariance_matrix = Matrix(covariance_matrix_df[:, 2:end])  # Assuming first column is ticker, exclude it

# Create the optimization model
model = Model(Gurobi.Optimizer)

# Define variables for asset percentages
@variable(model, weights[1:size(expected_returns, 1)] >= 0)

# Define the risk-free rate and risk aversion coefficient
risk_free_rate = 0.01  # Adjust this value as needed
lambda = 1.0  # Adjust this risk aversion coefficient as needed

# Define the objective function (maximize quadratic utility)
@objective(model, Max, sum(expected_returns[i] * weights[i] for i in 1:length(expected_returns)) - 
    lambda * sum(covariance_matrix[i, j] * weights[i] * weights[j] for i in 1:length(weights), j in 1:length(weights)))

# Define the budget as a percentage
budget = 1.0  # Total allocation must equal 100%

# Constraint: sum of weights must equal the budget
@constraint(model, sum(weights) == budget)

# Solve the optimization problem
optimize!(model)

# Check the optimization status
if termination_status(model) == MOI.OPTIMAL
    # Get the maximized objective value
    maximized_value = objective_value(model)

    # Print the optimized asset percentages
    println("Optimized Asset Percentages (Dollar Amounts):")
    for i in 1:length(weights)
        println("Asset ", i, " (", expected_returns_df.Ticker[i], "): \$", value(weights[i]) * 10000.0)  # Assuming initial investment is 10000
    end

    # Print the maximized objective value
    println("Maximized Objective Value: ", maximized_value)
else
    println("The optimization problem did not find an optimal solution.")
end

println("\nExplanation:")
println("The maximized objective value represents the highest expected return adjusted for risk according to the chosen utility function.")
println("This value is crucial for investors as it indicates the optimal allocation of funds across different assets")
println("to achieve the best possible return while managing risk.")
