import requests
import json

def fetch_api_data(api_url):
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception("Failed to fetch data from API")

def process_data(api_data):
    returns = []
    sentiment_scores = []
    
    for entry in api_data:
        returns.append(entry['return'])  # Assuming 'return' is the key for returns
        sentiment_scores.append(entry['sentiment'])  # Assuming 'sentiment' is the key for sentiment scores
    
    return returns, sentiment_scores
