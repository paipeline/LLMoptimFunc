# Data Extraction Plan

## Introduction

To effectively optimize our portfolio using the unified optimization function, we need to gather extensive and diverse financial data. This document outlines the plan for extracting the necessary data from financial APIs like Yahoo Finance.

## Data Requirements

### 1. Historical Prices
- **Data Needed**: 5-10 years of daily historical prices for each asset.
- **Description**: Daily historical prices for each asset.
- **Time Span**: At least 5-10 years.
- **Assets**: 30-50 diverse assets.

### 2. Financial Metrics
- **Data Needed**: Latest financial metrics for each company, including at least 5 key metrics.
- **Description**: Key financial metrics for each company.
- **Examples**: P/E ratio, EPS, revenue, net income, etc.

### 3. Company Overviews
- **Data Needed**: Overview data for each company, including at least 5 key attributes.
- **Description**: General information about each company.
- **Examples**: Industry, sector, market cap, etc.

### 4. Dividends
- **Data Needed**: Historical dividend data for each asset over the last 5-10 years.
- **Description**: Historical dividend data for each asset.
- **Time Span**: At least 5-10 years.

### 5. Earnings Data
- **Data Needed**: Historical earnings data for each company over the last 5-10 years.
- **Description**: Historical earnings data for each company.
- **Time Span**: At least 5-10 years.

### 6. Sentiment Data
- **Data Needed**: Sentiment scores from multiple sources, covering at least 1 year of data.
- **Description**: Sentiment scores from multiple sources.
- **Sources**: News articles, social media, analyst reports, etc.

### 7. Real-Time Quotes
- **Data Needed**: Real-time quotes for each asset, updated at least every minute.
- **Description**: Real-time price quotes for each asset.

### 8. Technical Indicators
- **Data Needed**: Technical indicators for each asset, calculated over the last 5 years.
- **Description**: Various technical indicators for each asset.
- **Examples**: Moving averages, RSI, MACD, etc.

## Yahoo Finance API Call Limits

The Yahoo Finance API has the following call limits:

- **Rate Limit**: 2 requests per second.
- **Daily Limit**: 1000 requests per day.
- **Data Limits**: Limited to 200 data points per request for historical data.

## APIs for Data Extraction

Several APIs can be utilized to gather the necessary financial data for our optimization function. Below are the recommended APIs:

- **Yahoo Finance API**: Provides historical prices, financial metrics, company overviews, dividends, and real-time quotes.
- **Alpha Vantage API**: Offers historical prices, financial metrics, technical indicators, and real-time quotes.
- **Finnhub API**: Supplies real-time quotes, historical prices, financial metrics, and sentiment data from news articles.
- **IEX Cloud API**: Delivers historical prices, financial metrics, and real-time quotes.
- **Polygon.io API**: Provides real-time quotes, historical prices, and financial metrics.

## Data Extraction Steps

### Step 1: Fetch Historical Prices
- **Function**: `fetch_historical_prices(symbol, outputsize='compact')`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 2: Fetch Financial Metrics
- **Function**: `fetch_financial_metrics(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 3: Fetch Company Overviews
- **Function**: `fetch_company_overview(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 4: Fetch Dividends
- **Function**: `fetch_dividends(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 5: Fetch Earnings Data
- **Function**: `fetch_earnings_data(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 6: Fetch Sentiment Data
- **Function**: `fetch_sentiment_data(symbol)`
- **API**: Various sentiment analysis APIs
- **Output**: Save data as JSON files in the `data` directory.

### Step 7: Fetch Real-Time Quotes
- **Function**: `fetch_real_time_quotes(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

### Step 8: Fetch Technical Indicators
- **Function**: `fetch_technical_indicators(symbol)`
- **API**: Yahoo Finance or Alpha Vantage
- **Output**: Save data as JSON files in the `data` directory.

## Conclusion

By following this data extraction plan, we will gather the necessary data to effectively optimize our portfolio using the unified optimization function. This comprehensive dataset will enable us to make informed trading decisions and enhance the overall performance of our trading strategy.
