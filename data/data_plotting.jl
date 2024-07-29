using CSV
using DataFrames
using Plots
using Statistics

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv", header=false) |> DataFrame

# Extract tickers from the expected returns DataFrame
tickers = expected_returns_df.Ticker

# Remove the first column from the covariance matrix DataFrame
covariance_matrix_df = covariance_matrix_df[:, 2:end]

# Convert covariance matrix to a correlation matrix
covariance_matrix = Matrix(covariance_matrix_df)
correlation_matrix = cor(covariance_matrix)

# Plot correlation heatmap
heatmap(tickers, tickers, correlation_matrix, title="Correlation Matrix Heatmap", xlabel="Tickers", ylabel="Tickers", color=:viridis)
savefig("data/correlation_matrix_heatmap.png")
