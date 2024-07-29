import requests
from datetime import datetime, timedelta

def scrape_news(api_url):
    """
    Scrapes news headlines over a period of a month from the given API.

    Args:
        api_url (str): The URL of the news API to scrape data from.

    Returns:
        list: A list of dictionaries containing date, news headline content, and source.
    """
    news_data = []
    end_date = datetime.now()
    start_date = end_date - timedelta(days=30)

    # Placeholder for API request
    response = requests.get(api_url, params={
        'from': start_date.strftime('%Y-%m-%d'),
        'to': end_date.strftime('%Y-%m-%d')
    })

    if response.status_code == 200:
        articles = response.json().get('articles', [])
        for article in articles:
            news_data.append({
                'date': article.get('publishedAt'),
                'headline': article.get('title'),
                'content': article.get('description'),
                'source': article.get('source', {}).get('name')
            })

    return news_data
