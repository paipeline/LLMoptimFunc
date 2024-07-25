import requests
import json

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

# Example usage
fetch_historical_prices('TSLA')
fetch_financial_metrics('TSLA')
 
 
 
 
from gradio_client import Client
import json

client = Client("https://fingpt-fingpt-forecaster.hf.space/--replicas/me7ol/")
result = client.predict(
        "TSLA", # str  in 'Ticker' Textbox component
        "2024-06-01",   # str  in 'Date' Textbox component
        4,  # int | float (numeric value between 1 and 4) in 'n_weeks' Slider component
        True,   # bool  in 'Use Latest Basic Financials' Checkbox component
        api_name="/predict"
)

# Save the result to a JSON file in the current directory
with open("data/prediction_result.json", "w") as json_file:
    json.dump(result, json_file)
 

