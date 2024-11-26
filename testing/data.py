# Import necessary libraries
import yfinance as yf
import pandas as pd

# Function to fetch and print Yahoo Finance data
def fetch_and_print_stock_data(ticker, start_date, end_date):
    print(f"Fetching data for ticker: {ticker}")
    
    # Download stock data from Yahoo Finance
    data = yf.download(ticker, start=start_date, end=end_date, interval="1d")
    
    # Print basic dataset information
    print("\nDataset Info:")
    print(data.info())
    
    # Print the first few rows of the entire dataset
    print("\nFirst few rows of the dataset:")
    print(data.head())

    # Extract the 'Close' prices
    close_prices = data.get('Close', pd.Series()).dropna()

    if close_prices.empty:
        print("No valid 'Close' prices available in the dataset.")
        return

    # Print the first few rows of the 'Close' series
    print("\nFirst few rows of the 'Close' series:")
    print(close_prices.head())

    # Print summary statistics for the 'Close' prices
    print("\nSummary statistics for 'Close' prices:")
    print(close_prices.describe())

    # Print the last few rows of the 'Close' series
    print("\nLast few rows of the 'Close' series:")
    print(close_prices.tail())

    # Print specific prices by index
    print("\nSpecific price examples:")
    print(f"First price: {close_prices.iloc[0]}")
    print(f"Last price: {close_prices.iloc[-1]}")
    if len(close_prices) > 10:
        print(f"Prices from index 5 to 10:\n{close_prices.iloc[5:11]}")

# Main script
if __name__ == "__main__":
    # Define parameters
    ticker = "VOO"  # Example ticker
    start_date = "2023-01-01"
    end_date = "2023-12-31"

    # Call the function to fetch and print data
    fetch_and_print_stock_data(ticker, start_date, end_date)
