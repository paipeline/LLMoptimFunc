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

# Define the selected stock tickers
selected_tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "FB", "ADBE", "CSCO", "INTC", "ORCL"]

# Calculate expected returns (mean of returns) for selected tickers
expected_returns = mean.(eachcol(data[!, selected_tickers])) .* 100

# Create a DataFrame for expected returns
expected_returns_df = DataFrame(Ticker = selected_tickers, Expected_Returns = expected_returns)

# Filter the data to include only selected tickers
filtered_data = data[:, [:Date] ∪ selected_tickers]

# Calculate the covariance matrix of the returns for the selected assets
covariance_matrix = cov(Matrix(filtered_data[!, Not(:Date)])) |> x -> round.(x, digits=4)

# Create a DataFrame for covariance matrix
covariance_matrix_df = DataFrame(covariance_matrix, :auto)
rename!(covariance_matrix_df, selected_tickers)
covariance_matrix_df[:, :Ticker] = selected_tickers

# Save expected returns to CSV
CSV.write("data/expected_returns.csv", expected_returns_df)

# Save covariance matrix to CSV
CSV.write("data/covariance_matrix.csv", covariance_matrix_df)

# Print confirmation messages
println("Expected returns saved to data/expected_returns.csv")
println("Covariance matrix saved to data/covariance_matrix.csv")
