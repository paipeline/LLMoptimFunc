using Statistics
using JSON

function load_predictions(file_path)
    open(file_path) do file
        return JSON.parse(file)
    end
end

predicted_returns = load_predictions("data/predicted_returns.json")

# Placeholder data
R_t = [0.01, 0.02, -0.01, 0.03, 0.04]  # Returns at time t
S_t = [0.1, 0.2, -0.1, 0.3, 0.4]       # Sentiment score at time t
R_f = 0.01                             # Risk-free rate
α = 0.5                                # Weight for sentiment in returns
β = 0.5                                # Weight for sentiment in risk
γ = 0.5                                # Weight for sentiment in Sharpe ratio
δ = 0.5                                # Weight for sentiment in optimization

# Unified optimization function with sentiment analysis
function optimize_with_sentiment(R_t, S_t, R_f, α, β, γ, δ)
    E_R = mean(R_t .+ γ .* S_t)
    σ_R = std(R_t .+ γ .* S_t)
    total_returns = sum(R_t .+ α .* S_t)
    risk = var(R_t .+ γ .* S_t)
    sharpe_ratio = (E_R - R_f) / σ_R
    return total_returns - β * risk + δ * sharpe_ratio
end

# Optimization function without sentiment analysis
function optimize_without_sentiment(R_t, R_f, β, δ)
    E_R = mean(R_t)
    σ_R = std(R_t)
    total_returns = sum(R_t)
    risk = var(R_t)
    sharpe_ratio = (E_R - R_f) / σ_R
    return total_returns - β * risk + δ * sharpe_ratio
end

optimized_value_with_sentiment = optimize_with_sentiment(predicted_returns, S_t, R_f, α, β, γ, δ)
println("Optimized Value with Sentiment: ", optimized_value_with_sentiment)
