import os
print("current directory")
print(os.getcwd())
import requests
from dotenv import load_dotenv
import json

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

def loop_fetch_news():
    for year in range(2022, 2025):  # Loop through years from 2022 to 2024
        months = []  # Reset months for each year
        for month in range(1, 13):
            if year == 2022 and month < 6:
                continue
            if year == 2024 and month > 7:
                break
            months.append(f"{month:02d}")
        tickers = list(ticker_mapping.values())
        for ticker in tickers:
            for month in months:
                    news_data = fetch_news(year, month, ticker)           
                    save_news_data(news_data, ticker, year, month.zfill(2))  # Ensure month is two digits
                    print(news_data)
                                                              
if __name__ == "__main__":                                   
    loop_fetch_news()
