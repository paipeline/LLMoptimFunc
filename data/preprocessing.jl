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

# Print the results
println("Expected Returns (in %):")
for (ticker, expected_return) in zip(names(data)[2:end], expected_returns_percentage)
    println("$ticker: $expected_return%")
end

println("\nCovariance Matrix:")
println(covariance_matrix)
