from gradio_client import Client

client = Client("https://fingpt-fingpt-forecaster.hf.space/--replicas/me7ol/")
result = client.predict(
		"TSLA",	# str  in 'Ticker' Textbox component
		"2024-06-24",	# str  in 'Date' Textbox component
		4,	# int | float (numeric value between 1 and 4) in 'n_weeks' Slider component
		True,	# bool  in 'Use Latest Basic Financials' Checkbox component
		api_name="/predict"
)
print(result)




import json
import numpy as np
from datetime import datetime
from textblob import TextBlob
import re

import json
import numpy as np
from datetime import datetime
from textblob import TextBlob
import re


# 读取原始JSON文件
with open('info.json', 'r') as file:
    data = json.load(file)
    

def calculate_volatility(price_data, window=None):
    closing_prices = [period['closing_price'] for period in price_data]
    returns = np.log(np.array(closing_prices[1:]) / np.array(closing_prices[:-1]))
    
    if window and len(returns) > window:
        volatility = np.std(returns[-window:]) * np.sqrt(252)
    else:
        volatility = np.std(returns) * np.sqrt(252)
    
    return volatility
    

def calculate_sentiment_score(text):
    return TextBlob(text).sentiment.polarity
# 使用 TextBlob 来计算文本的情感极性。
#这个得分范围是 -1 到 1，其中 -1 表示非常负面，1 表示非常正面，0 表示中性。



def calculate_impact_score(text):
    impact_keywords = ['significant', 'major', 'important', 'crucial', 'critical', 
                       'substantial', 'considerable', 'extensive', 'far-reaching']
    text = text.lower()
    impact_count = sum(1 for keyword in impact_keywords if keyword in text)
    return min(impact_count / len(impact_keywords), 1.0)  # 归一化到 0-1 之间
# 这个函数通过计算预定义的影响力关键词在文本中出现的频率来估算影响得分。
#得分范围是 0 到 1，其中 0 表示没有影响，1 表示最大影响。

#请注意，这种计算影响得分的方法相当简单，可能不够准确。
#在实际应用中，你可能需要使用更复杂的方法，例如训练一个专门的机器学习模型来评估新闻的影响力。



# 提取和清理数据
cleaned_data = {
    "qualitative_data": {
        "company_info": {
            "name": data["companyIntroduction"]["companyOverview"]["companyName"],
            "ticker": data["companyIntroduction"]["companyOverview"]["tickerSymbol"],
            "sector": data["companyIntroduction"]["companyOverview"]["sector"]
        },
        "sentiment_analysis": [],
        "analysis": {
            "positive_factors": data["analysis"]["positiveDevelopments"],
            "potential_concerns": data["analysis"]["potentialConcerns"],
            "prediction": data["analysis"]["predictionAndAnalysis"]["prediction"],
            "analysis_text": data["analysis"]["predictionAndAnalysis"]["analysis"]
        }
    },
    "quantitative_data": {
        "company_info": {
            "market_cap": data["companyIntroduction"]["companyOverview"]["marketCapitalization"]
        },
        "stock_price_movement": [],
        "financial_metrics": {
            "asset_turnover": data["basicFinancials"]["metrics"]["assetTurnoverTTM"],
            "current_ratio": data["basicFinancials"]["metrics"]["currentRatio"],
            "debt_to_equity": data["basicFinancials"]["metrics"]["totalDebtToEquity"],
            "return_on_equity": data["basicFinancials"]["metrics"]["roeTTM"],
            "price_to_book": data["basicFinancials"]["metrics"]["pb"],
            "price_to_earnings": data["basicFinancials"]["metrics"]["peTTM"]
        },
        "risk_metrics": {
            "beta": None,  # 这个数据在原始JSON中没有
        }
    }
}


# 处理股价变动和情感分析
for period in data["stockPriceAndNewsSummary"]["stockPriceMovement"]:
    price_movement = {
        "start_date": period["period"].split(" to ")[0],
        "end_date": period["period"].split(" to ")[1],
        "opening_price": period["openingPrice"],
        "closing_price": period["closingPrice"],
        "change": period["change"]
    }
    cleaned_data["quantitative_data"]["stock_price_movement"].append(price_movement)
    
    for news in period["newsHighlights"]:
        combined_text = news["headline"] + " " + news["summary"]
        sentiment = {
            "headline": news["headline"],
            "summary": news["summary"],
            "sentiment_score": calculate_sentiment_score(combined_text),
            "impact_score": calculate_impact_score(combined_text)
        }
        cleaned_data["qualitative_data"]["sentiment_analysis"].append(sentiment)




volatility = calculate_volatility(cleaned_data["quantitative_data"]["stock_price_movement"])
cleaned_data["quantitative_data"]["risk_metrics"]["volatility"] = volatility
# 由于数据点较少（只有几周的数据），计算得到的波动率可能不太准确。在实际应用中，你可能需要使用更长时间跨度的数据来获得更可靠的波动率估计。
# 如果你希望计算特定时间窗口的波动率（比如30天波动率），你可以在调用 calculate_volatility 函数时指定窗口大小，例如：
# volatility = calculate_volatility(cleaned_data["stock_price_movement"], window=30)


# 将清理后的数据写入新的JSON文件
with open('cleaned_stock_data.json', 'w') as file:
    json.dump(cleaned_data, file, indent=4)

print(f"数据清理完成，已写入cleaned_stock_data.json文件。")