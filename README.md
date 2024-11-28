# APSC200 Stock Trading Optimizer

This project is built under Queen's University and uses a both a consensus algorithm and Lloyd's algorithm

## Description

This stuff is pretty dense so this is a paragraph that attempts to describe the conceptual idea of our solution. Imagine there are 100 agents randomly distributed between 3 trading algorithms. Each agent has a different amount of money in each algorithm relative to their position (an agent between algorithms 1 and 2 but far from 3 may have 45% of their money in algorithm 1, 45% of their money in algorithm 2, and 10% in algorithm 3). At the end of the first trial, say a day, agents will be pulled to the leader (the agent that returned the most profit) relative to their performance. An agent that performs poorly will be pulled more, and an agent that performs well will be pulled less. After pulling all agents (all agents have "flocked", trial 1 is concluded. Then commences trial 2, say the second day, and each agent begins from their relative position. The performance of each agent is evaluated, and agents flock relative to performance towards the (most likely) new leader.

profit is read from a .csv file and updates with time!

## Testing
The testing folder contains Python code that runs three different algorithms on real stock data. These algorithms are:
1) Buy and Hold: Buys the stock and see how much it grows over the year
2) Mean reversion: Buys the stock if the previous day's return is negative and sells otherwise
3) Momentum: Buys the stock if the previous day's return is positive and sells otherwise

These three algorithms are run on VOO, Vanguard's index fund. Their relative profits are reported in "algos_relative_profit.csv", in decimal form (0.10 = 10%). This csv should replace the input csv of the matlab code when testing. Data.py displays data of the chosen stock, which acts to make the analysis process more comprehensive, but does not play a role in directly running the code.

## Results
We applied the determined optimal trading stratedgy onto unseen 2024 data (up until the first of November). Here are the results:  
Applied on 2024 data:  
Final Investment Results:  
buy_and_hold: $108.78  
mean_reversion: $57.48  
momentum: $1632.04  
  
Total Final Value: $1798.29  
Total Profit: $798.29  
 
### Dependencies

not sure if there are any but there will be for once we test on real data

### Installing

How to install matlab

### Executing program

* How to run the program
* Step-by-step bullets

## Authors

Simon Risk, Sai Kumar, Ben Lee, Matthew Sampson, Adam Baldesarra
