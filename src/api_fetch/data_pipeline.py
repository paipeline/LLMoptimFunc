import json
import requests
import numpy as np
from sklearn.linear_model import LinearRegression

API_KEY = '5U1CT3A3RMC8LJNR'

def fetch_historical_prices(symbol, outputsize='compact'):
    url = f'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol={symbol}&outputsize={outputsize}&apikey={API_KEY}'
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for bad responses
        data = response.json()
        if "Time Series (Daily)" in data:
            with open(f"data/{symbol}_historical_prices.json", "w") as json_file:
                json.dump(data["Time Series (Daily)"], json_file)
        else:
            print(f"Error fetching historical prices for {symbol}: {data.get('Note', 'No data available')}")

def fetch_financial_metrics(symbol):
    url = f'https://www.alphavantage.co/query?function=OVERVIEW&symbol={symbol}&apikey={API_KEY}'
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for bad responses
        data = response.json()
        with open(f"data/{symbol}_financial_metrics.json", "w") as json_file:
            json.dump(data, json_file)
    except Exception as e:
        print(f"Error fetching financial metrics for {symbol}: {e}")

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
