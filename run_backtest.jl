using DataFrames
using JSON

# Load the example data
function load_data(file_path::String)
    file = open(file_path, "r")
    data = JSON.parse(read(file, String))
    close(file)
    return DataFrame(data)
end

# Define a sample trading strategy
function sample_strategy(data::DataFrame)
    # Simple strategy: Buy if the sentiment score is above a threshold, sell otherwise
    return data.sentiment .> 0.5 ? "buy" : "sell"
end

# Main execution
data = load_data("example.json")
backtester = Backtester(sample_strategy, data)
backtester.run()
results = backtester.get_results()

println("Total Backtest Results: ", results)
println("Backtest completed successfully.")
