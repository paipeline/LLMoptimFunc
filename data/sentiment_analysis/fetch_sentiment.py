import os
import json
import requests
from dotenv import load_dotenv
import csv

ticker_mapping = {
    "Apple": "AAPL",
    "Microsoft": "MSFT",
    "Google": "GOOGL",
    "Amazon": "AMZN",
    "NVIDIA": "NVDA",
    "Meta": "FB",
    "Adobe": "ADBE",
    "Cisco": "CSCO",
    "Intel": "INTC",
    "Oracle": "ORCL",
    "Tesla": "TSLA",
}

load_dotenv()

# Oauth authentication with user credentials
username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
App_ID = os.getenv("APP_ID")

def fetch_news(year, month, ticker):
    month_start = f"{year}-{month}-01"
    month_end = f"{year}-{int(month) + 1}-01" if month != "12" else f"{year + 1}-01-01"
    token = requests.post("https://api.aylien.com/v1/oauth/token", auth=(username, password), data={"grant_type": "password"}).json()["access_token"]
    
    headers = {"Authorization": "Bearer {}".format(token), "AppId": App_ID}
    
    url = f'https://api.aylien.com/v6/news/stories?aql=text: ({ticker}) AND sentiment.title.polarity:(negative neutral positive)&cursor=*&published_at.end={month_end}T00:00:00.000Z&published_at.start={month_start}T00:00:00.000Z'
    
    response = requests.get(url, headers=headers)
    return response.json()

def save_news_data(data, ticker, year, month):
    file_path = f"data/sentiment_analysis/raw/{ticker}/{year}_{month}.json"
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    
    with open(file_path, 'w') as json_file:
        json.dump(data, json_file, indent=4)

def is_in_folder(ticker, year, month):
    file_path = f"data/sentiment_analysis/raw/{ticker}/{year}_{month}.json"
    return os.path.isfile(file_path)

def get_sentiment(ticker, year, month):
    file_path = f"data/sentiment_analysis/raw/{ticker}/{year}_{month}.json"
    with open(file_path, 'r') as json_file:
        data = json.load(json_file)
    sentiments = [{'title': story['sentiment']['title']['score'], 'body': story['sentiment']['body']['score']} for story in data.get('stories', [])]
    
    if not sentiments:
        print(f"No sentiments found for {ticker} for {year}-{month}")
        return 0  # or another appropriate value or handling for empty sentiments
    
    average_title_score = sum([sentiment['title'] for sentiment in sentiments]) / len(sentiments)
    average_body_score = sum([sentiment['body'] for sentiment in sentiments]) / len(sentiments)
    average_score = (average_title_score + average_body_score) / 2
    
    return average_score

def save_sentiments_to_csv(sentiments):
    file_path = "data/sentiment_analysis/sentiment/sentiments_monthly_score.csv"
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    
    file_exists = os.path.isfile(file_path)
    with open(file_path, 'a', newline='') as csv_file:
        fieldnames = ['ticker', 'year', 'month', 'sentiment_score']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

        if not file_exists:
            writer.writeheader()  # Write header only if file does not exist

        for sentiment in sentiments:
            writer.writerow(sentiment)

def loop_fetch_sentiments():
    sentiments = []
    tickers = list(ticker_mapping.values())
    for ticker in tickers:
        for year in range(2022, 2025):  # Loop through years from 2022 to 2024
            for month in range(1, 13):
                if year == 2022 and month < 6:
                    continue
                if year == 2024 and month > 7:
                    break
                month_str = f"{month:02d}"
                if is_in_folder(ticker, year, month_str):
                    average_score = get_sentiment(ticker, year, month_str)
                    sentiments.append({'ticker': ticker, 'year': year, 'month': month_str, 'average_score': average_score})
                else:
                    print(f"No data for {ticker} for {year}-{month_str}")
    
    save_sentiments_to_csv(sentiments)

if __name__ == "__main__":
    loop_fetch_sentiments()
