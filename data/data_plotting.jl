using CSV
using DataFrames
using Plots
using Statistics

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv", header=false) |> DataFrame

# Remove the first column from the expected returns DataFrame
expected_returns_df = expected_returns_df[:, 2:end]

# Remove the first column from the covariance matrix DataFrame
covariance_matrix_df = covariance_matrix_df[:, 2:end]

# Convert covariance matrix to a correlation matrix
covariance_matrix = Matrix(covariance_matrix_df)
correlation_matrix = cor(covariance_matrix)

# Plot correlation heatmap
heatmap(expected_returns_df[:, 1], expected_returns_df[:, 1], correlation_matrix, title="Correlation Matrix Heatmap", xlabel="Tickers", ylabel="Tickers", color=:viridis)
savefig("data/correlation_matrix_heatmap.png")
