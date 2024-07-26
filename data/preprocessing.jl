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

# Calculate expected returns (mean of returns) for all assets
expected_returns = mean.(eachcol(data[!, Not(:Date)])) |> x -> x .* 100

# Convert expected returns to percentage
expected_returns_percentage = expected_returns .* 100

# Create a DataFrame for expected returns
expected_returns_df = DataFrame(Ticker = selected_tickers, Expected_Returns = expected_returns)

# Define the selected stock tickers
selected_tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "FB", "ADBE", "CSCO", "INTC", "ORCL"]

# Create a DataFrame for expected returns
expected_returns_df = DataFrame(Ticker = names(data)[2:end], Expected_Returns = expected_returns)

# Filter expected returns to include only selected tickers
expected_returns_df = expected_returns_df[expected_returns_df.Ticker .∈ selected_tickers, :]

# Convert expected returns to percentage
expected_returns_percentage = expected_returns .* 100

# Filter the data to include only selected tickers
filtered_data = data[:, [:Date] .∪ selected_tickers]

# Calculate the covariance matrix of the returns for the selected assets
covariance_matrix = cov(Matrix(filtered_data[!, Not(:Date)])) |> x -> round.(x, digits=4)

# Create a DataFrame for covariance matrix
covariance_matrix_df = DataFrame(covariance_matrix, :auto)

# Filter covariance matrix to include only selected tickers
covariance_matrix_df = covariance_matrix_df[selected_tickers, selected_tickers]
rename!(covariance_matrix_df, selected_tickers)

# Define the selected stock tickers
selected_tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "FB", "ADBE", "CSCO", "INTC", "ORCL"]

# Create a DataFrame for expected returns
expected_returns_df = DataFrame(Ticker = names(data)[2:end], Expected_Returns = expected_returns_percentage)

# Filter expected returns to include only selected tickers
expected_returns_df = expected_returns_df[expected_returns_df.Ticker .∈ selected_tickers, :]

# Save expected returns to CSV
CSV.write("data/expected_returns.csv", expected_returns_df)

# Create a DataFrame for covariance matrix
covariance_matrix_df = DataFrame(covariance_matrix, :auto)

# Filter covariance matrix to include only selected tickers
covariance_matrix_df = covariance_matrix_df[selected_tickers, selected_tickers]
rename!(covariance_matrix_df, names(data)[2:end])

# Save covariance matrix to CSV
CSV.write("data/covariance_matrix.csv", covariance_matrix_df)

# Print confirmation messages
println("Expected returns saved to data/expected_returns.csv")
println("Covariance matrix saved to data/covariance_matrix.csv")
