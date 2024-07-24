# Function to maximize returns
function maximize_returns(returns)
    return sum(returns)
end

# Function to minimize risk (variance)
function minimize_risk(returns)
    mean_return = mean(returns)
    return sum((returns .- mean_return).^2) / (length(returns) - 1)
end

# Function to calculate Sharpe Ratio
function sharpe_ratio(returns, risk_free_rate)
    expected_return = mean(returns)
    return (expected_return - risk_free_rate) / std(returns)
end
