struct Backtester
    strategy::Function
    data::DataFrame
    results::Vector{Float64}

    function Backtester(strategy::Function, data::DataFrame)
        new(strategy, data, Float64[])
    end

    function run(self::Backtester)
        for i in 2:size(self.data, 1)
            signal = self.strategy(self.data[1:i, :])
            push!(self.results, execute_trade(signal, self.data[i, :]))
        end
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
