import requests
from dotenv import load_dotenv
import os

load_dotenv()
  
#Oauth authentication with user credentials
username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
App_ID = os.getenv("APP_ID")
  
def fetch_news(month, ticker): 
    month_start = month.strftime("%Y-%m-%d")  # Format month for URL
    month_end = month + 1
    month_end = month_end.strftime("%Y-%m-%d")  # Format month for URL
    month_str = month.strftime("%Y-%m")  # Format month for URL
    url = f'https://api.aylien.com/v6/news/stories?aql=text: ({ticker}) AND sentiment.title.polarity:(negative neutral positive)&cursor=*&published_at.end={month_str}-01T00:00:00.000Z&published_at.start={month_str}-01T00:00:00.000Z'
    # Requesting a bearer token from oauth endpoint
    #Review the docs for detailed authentication workflows docs.aylien.com/newsapi/v6
    token = requests.post("https://api.aylien.com/v1/oauth/token", auth=(username, password), data={"grant_type": "password"}).json()["access_token"]
    
    #Passing the token as a header with App Id
    headers = {"Authorization": "Bearer {}".format(token), "AppId":"4db0d080"}
    
    #V6 URL
    url = f'https://api.aylien.com/v6/news/stories?aql=text: ({ticker}) AND sentiment.title.polarity:(negative neutral positive)&cursor=*&published_at.end=2022-06-01T00:00:00.000Z&published_at.start=2022-05-01T00:00:00.000Z'
    
    response = requests.get(url, headers=headers)
    return response.json()



def test_fetch_news():                                       
    months = [("2022-05"), ("2022-06")]  # List of months to scrape
    ticker = "TSLKA"
    for month in months:
        news_data = fetch_news(month, ticker)                     
        print(news_data)                                         
                                                              
if __name__ == "__main__":                                   
    test_fetch_news()
