import requests
from dotenv import load_dotenv
import os

load_dotenv()
  
#Oauth authentication with user credentials
username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
App_ID = os.getenv("APP_ID")
  
#Requesting a bearer token from oauth endpoint
#Review the docs for detailed authentication workflows docs.aylien.com/newsapi/v6
token = requests.post("https://api.aylien.com/v1/oauth/token", auth=(username, password), data={"grant_type": "password"}).json()["access_token"]
  
#Passing the token as a header with App Id
headers = {"Authorization": "Bearer {}".format(token), "AppId":"4db0d080"}
  
#V6 URL
url = 'https://api.aylien.com/v6/news/stories?aql=text: (TESLA) AND sentiment.title.polarity:(negative neutral positive)&cursor=*&published_at.end=2022-06-01T00:00:00.000Z&published_at.start=2022-05-01T00:00:00.000Z'
  
response = requests.get(url, headers=headers)
print(response.json())
