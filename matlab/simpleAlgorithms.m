function profits = simpleAlgorithms(agentPositions)
%{
Computes the profit for each agent based on their proximity to the centroids
of three algorithms.

--- Input ---
agentPositions: n x 2 array of agent positions (x, y), hardcoded for simplicity.

--- Output ---
profits: n x 1 array of computed profits for each agent.

--- Hardcoded Values ---
Centroids for the algorithms:
    Algorithm 1: (2, 3) - Low profit return
    Algorithm 2: (6, 7) - Medium profit return
    Algorithm 3: (10, 2) - High profit return
Profit rates:
    Algorithm 1: 0.05
    Algorithm 2: 0.15
    Algorithm 3: 0.25
%}

% Hardcoded centroids for the three algorithms
centroids = [2, 3;   % Algorithm 1
             6, 7;   % Algorithm 2
             10, 2]; % Algorithm 3

% Hardcoded profit rates for each algorithm
profitRates = [0.05, 0.15, 0.25]; % Low, medium, high profits

nAgents = size(agentPositions, 1); % Number of agents
nAlgorithms = size(centroids, 1);  % Number of algorithms

% Initialize the profits array to store profits for each agent
profits = zeros(nAgents, 1);

% Loop through each agent to calculate their profit
for agent = 1:nAgents
    % Step 1: Calculate the Euclidean distance from the agent to each centroid
    distances = zeros(1, nAlgorithms);  % Store distances to each centroid
    for algo = 1:nAlgorithms
        % Calculate Euclidean distance between agent and each centroid
        distances(algo) = norm(agentPositions(agent, :) - centroids(algo, :));
    end
    
    % Step 2: Normalize the distances to compute weights
    % Inverse of distance gives higher weight to closer centroids
    % Add a small constant to avoid division by zero in case of perfect overlap
    epsilon = 1e-6;  % Small constant for stability
    normalizedDistances = 1 ./ (distances + epsilon); % Avoid division by zero
    weights = normalizedDistances / sum(normalizedDistances);  % Normalize weights to sum to 1
    
    % Step 3: Calculate the agent's profit as a weighted sum of profit rates
    profits(agent) = sum(weights .* profitRates);  % Weighted sum of the profit rates
end
end
