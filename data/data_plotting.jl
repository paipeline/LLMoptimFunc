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
savefig("expected_returns_plot.png")

# 2. Heatmap for covariance matrix
heatmap(covariance_matrix_df[!, Not(:AAPL)], title="Covariance Matrix Heatmap", xlabel="Tickers", ylabel="Tickers", color=:viridis)
savefig("covariance_matrix_heatmap.png")

# 3. Scatter plot for AAPL vs MSFT returns
scatter(expected_returns_df[expected_returns_df.Ticker .== "AAPL", :Expected_Returns], expected_returns_df[expected_returns_df.Ticker .== "MSFT", :Expected_Returns], label="AAPL vs MSFT", xlabel="AAPL Returns", ylabel="MSFT Returns", title="Scatter Plot: AAPL vs MSFT")
savefig("scatter_aapl_vs_msft.png")
