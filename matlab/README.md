# APSC200 Stock Trading Optimizer

This project is built under Queen's University and uses a both a consensus algorithm and Lloyd's algorithm

## Description

This stuff is pretty dense so this is a paragraph that attempts to describe the conceptual idea of our solution. Imagine there are 100 agents randomly distributed between 3 trading algorithms. Each agent has a different amount of money in each algorithm relative to their position (an agent between algorithms 1 and 2 but far from 3 may have 45% of their money in algorithm 1, 45% of their money in algorithm 2, and 10% in algorithm 3). At the end of the first trial, say a day, agents will be pulled to the leader (the agent that returned the most profit) relative to their performance. An agent that performs poorly will be pulled more, and an agent that performs well will be pulled less. After pulling all agents (all agents have "flocked", trial 1 is concluded. Then commences trial 2, say the second day, and each agent begins from their relative position. The performance of each agent is evaluated, and agents flock relative to performance towards the (most likely) new leader.

It is important to note here that this does not allow for recency bias, as the new leader (the centre of flocking for the next trial) had shifted closer to the leader of the previous trial. 

## Getting Started

### Dependencies

not sure if there are any but there will be for once we test on real data

### Installing

How to install matlab

### Executing program

* How to run the program
* Step-by-step bullets

## Authors

Simon Risk, Sai Kumar, Ben Lee, Matthew Sampson, Adam Baldesarra
