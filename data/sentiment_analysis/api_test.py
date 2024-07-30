import requests
from dotenv import load_dotenv
import os

load_dotenv()
  
#Oauth authentication with user credentials
username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
App_ID = os.getenv("APP_ID")
  
def fetch_news(year,month, ticker): 
    month_start = str(year + "-" + month + "-01")
    month_end = str(year + "-" + month+1 + "-01")
    print(month_end)
    token = requests.post("https://api.aylien.com/v1/oauth/token", auth=(username, password), data={"grant_type": "password"}).json()["access_token"]
    
    #Passing the token as a header with App Id
    headers = {"Authorization": "Bearer {}".format(token), "AppId":"4db0d080"}
    
    #V6 URL
    url = f'https://api.aylien.com/v6/news/stories?aql=text: ({ticker}) AND sentiment.title.polarity:(negative neutral positive)&cursor=*&published_at.end={month_end}T00:00:00.000Z&published_at.start={month_start}T00:00:00.000Z'
    
    response = requests.get(url, headers=headers)
    return response.json()



def test_fetch_news():                                       
    months = [("05"), ("06")]  
    ticker = "TESLA"
    for month in months:
        news_data = fetch_news(2022, month, ticker)           
        print(news_data)                               
                                                              
if __name__ == "__main__":                                   
    test_fetch_news()
