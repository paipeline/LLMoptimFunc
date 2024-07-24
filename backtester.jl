struct Backtester
    strategy::Function
    data::DataFrame
    results::Vector{Float64}

    function Backtester(strategy::Function, data::DataFrame)
        new(strategy, data, Float64[])
    end

    function run(self::Backtester)
        self.results = Float64[]  # Initialize results
        for i in 1:size(self.data, 1)  # Start from the first row
            signal = self.strategy(self.data[1:i, :])
            push!(self.results, execute_trade(signal, self.data[i, :]))
        end
        return self.results  # Return results after running
    end

    function execute_trade(signal::String, current_data::DataFrame)
        if signal == "buy"
            return current_data.return  # Assuming 'return' is the key for returns
        elseif signal == "sell"
            return -current_data.return
        end
        return 0.0
    end

    function get_results(self::Backtester)
        return sum(self.results)
    end
end
