import pandas as pd

# Define total initial investment and allocation percentages
total_investment = 1000
allocation_percentages = {
    "buy_and_hold": 0.5995,
    "mean_reversion": 0.2069,
    "momentum": 0.1936
}

# Load the CSV file with daily returns
input_file = "VOO_relative_profit.csv"  # Replace with your file name
data = pd.read_csv(input_file)

# Initialize a dictionary to store the final value for each algorithm
final_values = {}

# Calculate the final value for each algorithm
for algo, percentage in allocation_percentages.items():
    initial_investment = total_investment * percentage
    # Compute cumulative growth multiplier
    cumulative_multiplier = (1 + data[algo]).prod()  # Product of (1 + daily return)
    # Calculate final value
    final_value = initial_investment * cumulative_multiplier
    final_values[algo] = final_value

# Calculate the total profit
total_final_value = sum(final_values.values())
total_profit = total_final_value - total_investment

# Print results
print("Final Investment Results:")
for algo, value in final_values.items():
    print(f"{algo}: ${value:.2f}")
print(f"\nTotal Final Value: ${total_final_value:.2f}")
print(f"Total Profit: ${total_profit:.2f}")