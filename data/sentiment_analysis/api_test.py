import os
print("current directory")
print(os.getcwd())
import requests
from dotenv import load_dotenv
import json
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
  
def fetch_news(year,month,ticker): 
    month_start = f"{year}-{month}-01"
    month_end = f"{year}-{int(month) + 1}-01" if month != "12" else f"{year + 1}-01-01"
    print(month_end)
    token = requests.post("https://api.aylien.com/v1/oauth/token", auth=(username, password), data={"grant_type": "password"}).json()["access_token"]
    
    #Passing the token as a header with App Id
    headers = {"Authorization": "Bearer {}".format(token), "AppId":"4db0d080"}
    
    #V6 URL
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

def loop_fetch_news():
    tickers = list(ticker_mapping.values())
    for ticker in tickers:
        for year in range(2022, 2025):  # Loop through years from 2022 to 2024
            for month in range(1, 13):
                if year == 2022 and month < 6:
                    continue
                if year == 2024 and month > 7:
                    break
                month_str = f"{month:02d}"
                print(f"Fetching news for {ticker} for {year}-{month_str}")
                if is_in_folder(ticker, year, month_str):
                    print(f"Already fetched news for {ticker} for {year}-{month_str}")
                    continue
                news_data = fetch_news(year, month_str, ticker)
                save_news_data(news_data, ticker, year, month_str)  # Ensure month is two digits
                sentiments = get_sentiment(ticker, year, month_str)
                save_sentiments_to_csv(sentiments, ticker, year, month_str)
                # print(news_data)


def save_sentiments_to_csv(sentiments, ticker, year, month):
    file_path = f"data/sentiment_analysis/sentiments.csv"
    file_exists = os.path.isfile(file_path)

    with open(file_path, 'a', newline='') as csv_file:
        fieldnames = ['year', 'month', 'ticker', 'sentiment']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

        if not file_exists:
            writer.writeheader()  # Write header only if file does not exist

        for sentiment in sentiments:
            writer.writerow({'year': year, 'month': month, 'ticker': ticker, 'sentiment': sentiment})
            
def get_sentiment(ticker, year, month):
    file_path = f"data/sentiment_analysis/raw/{ticker}/{year}_{month}.json"
    with open(file_path, 'r') as json_file:
        data = json.load(json_file)
    sentiments = [story['sentiment'] for story in data.get('stories', [])]
    return sentiments
    



if __name__ == "__main__":                                   
    # loop_fetch_news()
