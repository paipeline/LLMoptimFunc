import requests
from bs4 import BeautifulSoup

def fetch_yahoo_finance_data(ticker):
    url = f'https://finance.yahoo.com/quote/{ticker}/news?p={ticker}'
    response = requests.get(url)
    if response.status_code != 200:
        return None
    soup = BeautifulSoup(response.text, 'html.parser')
    news_items = []
    for item in soup.find_all('li', class_='js-stream-content'):
        headline = item.find('h3').get_text() if item.find('h3') else None
        date = item.find('time')['datetime'] if item.find('time') else None
        source = item.find('span', class_='C(#959595)').get_text() if \
        item.find('span', class_='C(#959595)') else None
        if headline and date and source:
            news_items.append({'headline': headline, 'date': date, 'source': source})
    return news_items


def get_finnhub_news(ticker, api_key):
    import requests

    url = f'https://finnhub.io/api/v1/company-news?symbol={ticker}&from=2022-01-01&to={datetime.now().strftime("%Y-%m-%d")}&token={api_key}'
    response = requests.get(url)
    if response.status_code != 200:
    return response.json()
