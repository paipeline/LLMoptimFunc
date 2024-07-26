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

# Create a DataFrame for expected returns with date and ticker
expected_returns_df = DataFrame(Date = data[!, :Date], Ticker = names(data)[2:end], Expected_Returns = expected_returns_percentage)

# Save expected returns to CSV
CSV.write("data/expected_returns.csv", expected_returns_df)

# Create a DataFrame for covariance matrix with tickers as row and column headers
covariance_matrix_df = DataFrame(covariance_matrix, :auto)
names!(covariance_matrix_df, names(data)[2:end])

# Save covariance matrix to CSV
CSV.write("data/covariance_matrix.csv", covariance_matrix_df)

# Print confirmation messages
println("Expected returns saved to data/expected_returns.csv")
println("Covariance matrix saved to data/covariance_matrix.csv")
