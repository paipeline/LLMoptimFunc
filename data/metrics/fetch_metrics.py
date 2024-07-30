import requests

def fetch_metrics_for_month(ticker, year, month):
    base_url = "https://query1.finance.yahoo.com/v8/finance/chart/"
    url = f"{base_url}{ticker}?range=1mo&interval=1d&events=div|split&includeAdjustedClose=true"
    
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Error fetching data: {response.status_code}")

    data = response.json()
    metrics = {
        "ticker": ticker,
        "year": year,
        "month": month,
        "data": data['chart']['result'][0]  # Extract relevant data
    }
    """
    Fetch metrics for a specific ticker over a given month and year.
    """
    return metrics
    return metrics
