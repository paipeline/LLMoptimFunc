import json
import requests
import numpy as np
from sklearn.linear_model import LinearRegression

API_KEY = 'your_alpha_vantage_api_key'

def fetch_historical_prices(symbol, outputsize='compact'):
    url = f'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol={symbol}&outputsize={outputsize}&apikey={API_KEY}'
    response = requests.get(url)
    data = response.json()
    with open(f"data/{symbol}_historical_prices.json", "w") as json_file:
        json.dump(data, json_file)

def fetch_financial_metrics(symbol):
    url = f'https://www.alphavantage.co/query?function=OVERVIEW&symbol={symbol}&apikey={API_KEY}'
    response = requests.get(url)
    data = response.json()
    with open(f"data/{symbol}_financial_metrics.json", "w") as json_file:
        json.dump(data, json_file)

def load_data(file_path):
    with open(file_path, "r") as file:
        return json.load(file)

def predict_returns(prices):
    X = np.arange(len(prices)).reshape(-1, 1)
    y = np.array(prices)
    model = LinearRegression().fit(X, y)
    return model.predict(X)

def save_predictions(predictions, file_path):
    with open(file_path, "w") as file:
        json.dump(predictions.tolist(), file)

def main():
    # Example usage
    symbol = 'TSLA'
    fetch_historical_prices(symbol)
    fetch_financial_metrics(symbol)

    historical_prices = load_data(f"data/{symbol}_historical_prices.json")
    predicted_returns = predict_returns(historical_prices)
    save_predictions(predicted_returns, "data/predicted_returns.json")

if __name__ == "__main__":
    main()
