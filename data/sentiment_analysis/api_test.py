import requests
from dotenv import load_dotenv
import json
import os

load_dotenv()
  
#Oauth authentication with user credentials
username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
App_ID = os.getenv("APP_ID")
  
def fetch_news(year,month, ticker): 
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
    directory = f"data/{ticker}/{year}_{month}"
    os.makedirs(directory, exist_ok=True)
    file_path = os.path.join(directory, "news_data.json")
    
    with open(file_path, 'w') as json_file:
        json.dump(data, json_file, indent=4)

def test_fetch_news():
    months = [("06"), ("07")]  
    ticker = "TESLA"
    for month in months:
        news_data = fetch_news(2022, month, ticker)           
        save_news_data(news_data, ticker, 2022, month)
        print(news_data)
                                                              
if __name__ == "__main__":                                   
    test_fetch_news()
