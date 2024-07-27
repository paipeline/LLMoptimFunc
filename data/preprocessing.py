import pandas as pd
import numpy as np
import os

# Define the file path
file_path = "data/sp500/returns.csv"

# Check if the file exists
if not os.path.isfile(file_path):
    raise FileNotFoundError(f"File not found: {file_path}")

# Load the simplified return data
data = pd.read_csv(file_path, header=0)

# Define the selected tech stock tickers
selected_tickers = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'NVDA', 'FB', 'ADBE', 'CSCO', 'INTC', 'ORCL']

# Filter the data to include only selected tickers
filtered_data = data[['Date'] + selected_tickers]

# Calculate expected returns (mean of returns) for selected tickers
expected_returns = filtered_data[selected_tickers].mean() * 100

# Create a DataFrame for expected returns
expected_returns_df = pd.DataFrame({'Ticker': selected_tickers, 'Expected_Returns': expected_returns})

# Calculate the correlation matrix of the returns for the selected assets
correlation_matrix = filtered_data[selected_tickers].corr().round(4)

# Create a DataFrame for correlation matrix
correlation_matrix_df = pd.DataFrame(correlation_matrix, columns=selected_tickers, index=selected_tickers)

# Save correlation matrix to CSV
correlation_matrix_df.to_csv("data/correlation_matrix.csv")

# Convert correlation matrix to covariance matrix using the standard deviations
std_devs = filtered_data[selected_tickers].std()
covariance_matrix = correlation_matrix * np.outer(std_devs, std_devs)

# Filter the covariance matrix to include only the selected tickers
covariance_matrix = covariance_matrix[selected_tickers].loc[selected_tickers]

# Create a DataFrame for covariance matrix
covariance_matrix_df = pd.DataFrame(covariance_matrix, columns=selected_tickers, index=selected_tickers)

# Create a condensed DataFrame with only the ticker data
condensed_data = filtered_data[['Date'] + selected_tickers]

# Save the condensed data to CSV
condensed_data.to_csv("data/condensed_data.csv", index=False)

# Save expected returns to CSV
expected_returns_df.to_csv("data/expected_returns.csv", index=False)

# Save covariance matrix to CSV
covariance_matrix_df.to_csv("data/covariance_matrix.csv")

# Print confirmation messages
print("Expected returns saved to data/expected_returns.csv")
print("Covariance matrix saved to data/covariance_matrix.csv")
