import yfinance as yf
import pandas as pd

# User-defined date range
start_date = input("Enter the start date (YYYY-MM-DD): ")  # e.g., "2024-01-01"
end_date = input("Enter the end date (YYYY-MM-DD): ")      # e.g., "2024-11-27"

# Define trading algorithms
def buy_and_hold(prices, i):
    """Buy and hold: profit based on daily price change."""
    if i > 0:
        return (prices.iloc[i] - prices.iloc[i - 1]) / prices.iloc[i - 1]
    return 0

def mean_reversion(prices, i):
    """Mean reversion: buys if the previous day's return is negative, sells otherwise."""
    if i > 0:
        if i > 1:
            prev_return = ((prices.iloc[i - 1] - prices.iloc[i - 2]) / prices.iloc[i - 2]).item()
        else:
            prev_return = 0
        return prev_return if prev_return < 0 else 0
    return 0

def momentum(prices, i):
    """Momentum: buys if the previous day's return is positive, sells otherwise."""
    if i > 1:
        # Ensure prev_return is a scalar by explicitly calculating it
        prev_return = (prices.iloc[i - 1] - prices.iloc[i - 2]) / prices.iloc[i - 2]
        
        # Only take today's return if prev_return is positive
        if prev_return > 0:
            return (prices.iloc[i] - prices.iloc[i - 1]) / prices.iloc[i - 1]
    return 0

# Download stock data
ticker = "VOO"

print(f"Downloading data for {ticker} from {start_date} to {end_date}...")
data = yf.download(ticker, start=start_date, end=end_date, interval="1d")
# Download stock data
print(f"Downloading data for {ticker} from {start_date} to {end_date}...")
data = yf.download(ticker, start=start_date, end=end_date, interval="1d")
# Download stock data
print(f"Downloading data for {ticker} from {start_date} to {end_date}...")
data = yf.download(ticker, start=start_date, end=end_date, interval="1d")

# Check if the data is empty
if data.empty:
    raise ValueError("No data was downloaded. Check the ticker symbol or date range.")

# Flatten the DataFrame if it has multi-index columns
if isinstance(data.columns, pd.MultiIndex):
    data.columns = ['_'.join(col).strip() for col in data.columns.values]

# Check the structure of the flattened data
print(data.head())

# Extract the 'Close' prices explicitly
try:
    prices = data["Close"] if "Close" in data else data[f"Close_{ticker}"]
    prices = prices.dropna()  # Remove NaN values
except KeyError:
    raise ValueError("Unable to extract 'Close' prices. Check if the ticker or data format is correct.")

# Validate the extracted prices
if prices.empty or not isinstance(prices, pd.Series):
    raise ValueError("Prices should be a non-empty Pandas Series. Check your data extraction.")

# Display the extracted prices (optional)
print(prices.head())

# Initialize lists to store daily profits for each algorithm
buy_and_hold_profits = [0]
mean_reversion_profits = [0]
momentum_profits = [0]

# Calculate profits for each algorithm
for i in range(1, len(prices)):
    buy_and_hold_profits.append(buy_and_hold(prices, i))
    mean_reversion_profits.append(mean_reversion(prices, i))
    momentum_profits.append(momentum(prices, i))

# Create a DataFrame to store results
results = pd.DataFrame({
    "buy_and_hold": buy_and_hold_profits,
    "mean_reversion": mean_reversion_profits,
    "momentum": momentum_profits
})

# Data cleaning: Ensure all profit columns are numerical
for col in ["buy_and_hold", "mean_reversion", "momentum"]:
    results[col] = pd.to_numeric(results[col], errors='coerce')  # Convert non-numeric to NaN
    results[col] = results[col].fillna(0)  # Replace NaN with 0 (optional)

# Save the results to a CSV file
output_file = "VOO_relative_profit.csv"
results.to_csv(output_file, index=False, float_format="%.6f")  # Save with controlled decimal precision
print(f"Results saved to {output_file}")

# Optional: Display the first few rows of results
print(results.head())
