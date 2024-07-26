using CSV
using DataFrames
using JuMP, Gurobi, BayesianOptimization, Plots

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv") |> DataFrame

# Extract expected returns and covariance matrix
expected_returns = expected_returns_df.Expected_Returns
covariance_matrix = Matrix(covariance_matrix_df)

# Define the initial investment amount
initial_investment = 10000.0  # Adjust this value as needed

# Define the budget as a percentage
budget = 1.0  # Total allocation must equal 100%

# Function to evaluate the model with a given lambda
function evaluate_model(lambda::Float64)
    model = Model(Gurobi.Optimizer)

    # Define variables for asset percentages
    @variable(model, percentages[1:size(expected_returns, 1)] >= 0)

    # Define the objective function (maximize expected return and minimize variance)
    @objective(model, Max, sum(expected_returns[i] * percentages[i] for i in 1:length(expected_returns)) - 
        lambda * sum(covariance_matrix[i, j] * percentages[i] * percentages[j] for i in 1:length(expected_returns) for j in 1:length(expected_returns)))

    # Constraint: sum of weights must equal the budget
    @constraint(model, sum(percentages) == 1.0)  # Total allocation must equal 100%

    # Solve the optimization problem
    optimize!(model)

    # Return the maximized value
    return objective_value(model)
end

# Hyperparameter tuning using Bayesian optimization combined with grid search
function tune_lambda()
    # Define a range of values for λ
    lambda_values = 0.0:0.1:1.0  # Adjust the range and step size as needed

    # Store results for each λ
    results = Dict{Float64, Float64}()

    # Perform grid search
    for λ in lambda_values
        result = evaluate_model(λ)
        results[λ] = result
    end

    # Perform Bayesian optimization
    f(x) = evaluate_model(x[1])
    bounds = [0.0 1.0]
    res = BayesianOptimization.optimize(f, bounds; method=:tree_parzen_estimator, num_init_samples=5, num_iterations=25)

    best_lambda = res.optimal_parameters[1]

    return best_lambda, results
end

# Cross-validation function to evaluate performance
function cross_validation()
    best_lambda, results = tune_lambda()
    return best_lambda, results
end

# Function to pick the best lambda
function pick_best_lambda(results)
    best_lambda = argmax(values(results))  # Get the index of the maximum value
    return keys(results)[best_lambda]  # Return the best lambda
end

# Main execution
best_lambda, results = cross_validation()
optimal_lambda = pick_best_lambda(results)

# Plotting the results
lambdas = collect(keys(results))
values = collect(values(results))

scatter(lambdas, values, label="Cross-Validation Results", xlabel="Lambda (λ)", ylabel="Maximized Value", title="Cross-Validation of Lambda")
scatter!([optimal_lambda], [evaluate_model(optimal_lambda)], label="Best Lambda", color=:red, markersize=8)

println("Optimal Lambda: ", optimal_lambda)
println("Maximized Value at Optimal Lambda: ", evaluate_model(optimal_lambda))
