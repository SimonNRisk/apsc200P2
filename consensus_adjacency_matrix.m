function A = consensus_adjacency_matrix(y, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3, nagents)
%{
Let "n" be the number of agents.

--- Inputs ---
y: n by 2 array holding output data for all agents
   e.g., y(j,2) is the second output for agent-j

CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y: Coordinates of the centroids
PROFIT1, PROFIT2, PROFIT3: Profit rates for each centroid
nagents: number of agents in the system

--- Outputs ---
A:  n by n adjacency matrix - see notes for details on construction
%}

% Calculate profits using the profitFunction
profitMatrix = profitFunction(y, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3);

% Identify the leader based on highest profit
[~, leader] = max(profitMatrix(:, 1));  % Get the index of the agent with highest profit

% Initialize adjacency matrix with zeros
A = zeros(nagents, nagents);  % Use nagents to create the correct size matrix

% Set 1s in the leader's row and column to indicate communication with all other agents
A(leader, :) = 1;  % Leader row (leader talks to everyone)
A(:, leader) = 1;  % Leader column (everyone talks to leader)

end
