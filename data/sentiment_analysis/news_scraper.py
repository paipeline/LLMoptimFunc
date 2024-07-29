import requests
from datetime import datetime, timedelta

def get_finnhub_news(ticker, date, api_key):
    date_from = f'{date}T00:00:00Z'
    date_to = f'{date}T23:59:59Z'
    url = f'https://finnhub.io/api/v1/company-news?symbol={ticker}&from={date_from}&to={date_to}&token={api_key}'
    response = requests.get(url)
    if response.status_code != 200:
        return None
    news_data = response.json()
    sorted_news = sorted(news_data, key=lambda x: x['importance'], reverse=True)[:5]
    return sorted_news


if __name__ == "__main__":
    ticker = "AAPL"  # Example ticker symbol
    api_key = "your_api_key_here"  # Replace with your actual API key
    start_date = datetime(2024, 1, 1)  # Example start date
    end_date = datetime(2024, 1, 31)  # Example end date

    news = get_monthly_news(ticker, start_date, end_date, api_key)
    print(news)

def get_monthly_news(ticker, start_date, end_date, api_key):
    all_news = []
    current_date = start_date
    while current_date <= end_date:
        news = get_finnhub_news(ticker, current_date.strftime('%Y-%m-%d'), api_key)
        if news:
            all_news.extend(news)
        current_date += timedelta(days=1)
    return all_news
