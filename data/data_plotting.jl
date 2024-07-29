using CSV
using DataFrames
using Plots

# Load expected returns and covariance matrix
expected_returns_df = CSV.File("data/expected_returns.csv") |> DataFrame
covariance_matrix_df = CSV.File("data/covariance_matrix.csv") |> DataFrame

# Extract expected returns and tickers
tickers = expected_returns_df.Ticker
expected_returns = expected_returns_df.Expected_Returns

# 1. Bar plot for expected returns
bar(tickers, expected_returns, label="Expected Returns", xlabel="Tickers", ylabel="Expected Return (%)", title="Expected Returns of Selected Tickers", legend=:topright)
savefig("data/expected_returns_plot.png")

# Create a correlation matrix
correlation_matrix = cor(Matrix(covariance_matrix_df[!, 2:end]))

# 2. Heatmap for correlation matrix
heatmap(correlation_matrix, title="Correlation Matrix Heatmap", xlabel="Tickers", ylabel="Tickers", color=:viridis)
savefig("data/covariance_matrix_heatmap.png")
