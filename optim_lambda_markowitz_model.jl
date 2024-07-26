using CSV
using DataFrames
using JuMP
using Gurobi
using Plots

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv") |> DataFrame

# Extract expected returns and covariance matrix, ensuring they are not empty
if nrow(expected_returns_df) == 0 || nrow(covariance_matrix_df) == 0
    error("Expected returns or covariance matrix is empty.")
end
expected_returns = expected_returns_df.Expected_Returns
covariance_matrix = Matrix(covariance_matrix_df)

# Define the initial investment amount
initial_investment = 10000.0  # Adjust this value as needed

# Function to evaluate the model with a given lambda
function evaluate_model(λ::Float64)
    model = Model(Gurobi.Optimizer)

    # Define variables for asset percentages
    @variable(model, percentages[1:size(expected_returns, 1)] >= 0)

    # Define the objective function (maximize expected return and minimize variance)
    @objective(model, Max, sum(expected_returns[i] * percentages[i] for i in 1:length(expected_returns)) - 
        λ * sum(covariance_matrix[i, j] * percentages[i] * percentages[j] for i in 1:length(expected_returns) for j in 1:length(expected_returns)))

    # Constraint: sum of weights must equal the budget
    @constraint(model, sum(percentages) == 1.0)  # Total allocation must equal 100%

    # Solve the optimization problem to find the optimal asset allocation
    optimize!(model)

    # Return the maximized value
    return objective_value(model), percentages
end

# Hyperparameter tuning using grid search
function tune_lambda()
    # Define a range of values for λ
    lambda_values = 0.0:0.05:1.0  # Create more lambda values for tuning

    # Store results for each λ
    results = Dict{Float64, Float64}()

    # Perform grid search
    for λ in lambda_values
        result, _ = evaluate_model(λ)
        results[λ] = result
    end

    return results
end

# Function to pick the best lambda
function pick_best_lambda(results::Dict{Float64, Float64})
    best_lambda = argmax(λ -> results[λ], keys(results))
    return best_lambda
end

# Main execution
results = tune_lambda()
optimal_lambda = pick_best_lambda(results)

# Plotting the results
lambda_values = collect(keys(results))
objective_values = collect(values(results))

p = plot(lambda_values, objective_values, label="Optimal Value Curve", xlabel="Lambda (λ)", ylabel="Maximized Value", title="Optimal Value vs Individual Asset Values", legend=:topright)
for i in 1:length(expected_returns)
    asset_values = [evaluate_model(λ)[1] for λ in lambda_values]  # Calculate asset values for each lambda
    asset_allocations = [evaluate_model(λ)[2] for λ in lambda_values]  # Calculate asset allocations for each lambda
    asset_allocations = [evaluate_model(λ)[2] for λ in lambda_values]  # Calculate asset allocations for each lambda
    plot!(lambda_values, [asset_allocations[j][i] for j in 1:length(lambda_values)], label="Asset $i Value", linestyle=:dash)
end
scatter!(p, [optimal_lambda], [results[optimal_lambda]], label="Best Lambda", color=:red, markersize=8)

# Plot asset allocations for the best lambda
best_allocation = asset_allocations[argmax(lambda_values .== optimal_lambda)]
bar_labels = ["Asset $i" for i in 1:length(best_allocation)]
bar(bar_labels, best_allocation, label="Best Asset Allocation", color=:blue, alpha=0.5)

println("Optimal Lambda: ", optimal_lambda)
println("Maximized Value at Optimal Lambda: ", results[optimal_lambda])

# Save the plot
savefig(p, "lambda_optimization_plot.png")
