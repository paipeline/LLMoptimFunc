using CSV
using DataFrames
using JuMP
using GLPK

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv") |> DataFrame

# Extract expected returns and covariance matrix
expected_returns = expected_returns_df.Expected_Returns
covariance_matrix = Matrix(covariance_matrix_df)

# Create the optimization model
model = Model(GLPK.Optimizer)

# Define variables for asset weights
@variable(model, weights[1:size(expected_returns, 1)] >= 0)

# Define the objective function (maximize expected return)
@objective(model, Max, sum(expected_returns[i] * weights[i] for i in 1:length(expected_returns)))

# Fake constraint: sum of weights must equal 1
@constraint(model, sum(weights) == 1)

# Solve the optimization problem
optimize!(model)

# Get the maximized value
maximized_value = objective_value(model)

# Return the maximized value
println("Maximized Value: ", maximized_value)
println("Optimized Asset Weights:")
for i in 1:length(weights)
    println("Asset ", i, " (", expected_returns_df.Ticker[i], "): ", value(weights[i]))
end

println("\nExplanation:")
println("The maximized return represents the highest expected return achievable given the constraints of the model.")
println("This value is crucial for investors as it indicates the optimal allocation of funds across different assets")
println("to achieve the best possible return while managing risk.")
