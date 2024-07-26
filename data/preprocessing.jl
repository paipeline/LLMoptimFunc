using CSV
using DataFrames
using Statistics

# Define the file path
file_path = "data/sp500/simplified_return.csv"

# Check if the file exists
if !isfile(file_path)
    error("File not found: $file_path")
end

# Load the simplified return data
data = CSV.File(file_path) |> DataFrame

# Calculate expected returns (mean of returns)
expected_returns = mean.(eachcol(data[!, Not(:Date)])) |> x -> x .* 100

# Convert expected returns to percentage
expected_returns_percentage = expected_returns .* 100

# Calculate the covariance matrix of the returns
covariance_matrix = cov(Matrix(data[!, Not(:Date)])) |> x -> round.(x, digits=4)

# Define the selected stock tickers
selected_tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "FB", "ADBE", "CSCO", "INTC", "ORCL"]

# Create a DataFrame for expected returns
expected_returns_df = DataFrame(Ticker = names(data)[2:end], Expected_Returns = expected_returns_percentage)

# Filter expected returns to include only selected tickers
expected_returns_df = expected_returns_df[in.(expected_returns_df.Ticker, selected_tickers), :]

# Save expected returns to CSV
CSV.write("data/expected_returns.csv", expected_returns_df)

# Create a DataFrame for covariance matrix
covariance_matrix_df = DataFrame(covariance_matrix, :auto)

# Filter covariance matrix to include only selected tickers
covariance_matrix_df = covariance_matrix_df[in.(names(data)[2:end], selected_tickers), in.(names(data)[2:end], selected_tickers)]
rename!(covariance_matrix_df, names(data)[2:end])

# Save covariance matrix to CSV
CSV.write("data/covariance_matrix.csv", covariance_matrix_df)

# Print confirmation messages
println("Expected returns saved to data/expected_returns.csv")
println("Covariance matrix saved to data/covariance_matrix.csv")
