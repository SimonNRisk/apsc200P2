
function [profitMatrix, leader] = profitFunction(y, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3)
%{
Let "n" be the number of agents.

--- Inputs ---
y: n x 2 array holding output data for all agents
   e.g., y(j,2) is the second output for agent-j

CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y: Coordinates of the centroids
PROFIT1, PROFIT2, PROFIT3: Profit rates for each centroid

--- Outputs ---
profitMatrix: n x 3 array where each row contains the agent's profit data
leader: the index of the agent with the highest profit
%}

nAgents = size(y, 1);  % Get the number of agents from the size of y

profitMatrix = zeros(nAgents, 3);
highestProfit = -100000000; %so we always better than highest profit
leader = 1; %holds index of agent with highest profit
totalProfitDelta = 0; %sum of relative profits for normalization

for agent = 1:nAgents
    % Calculate profit for each agent based on proximity to centroids
    distance1 = ((y(agent, 1)-CENTROID1X)^2 + (y(agent, 2)-CENTROID1Y)^2)^(1/2);
    distance2 = ((y(agent, 1)-CENTROID2X)^2 + (y(agent, 2)-CENTROID2Y)^2)^(1/2);
    distance3 = ((y(agent, 1)-CENTROID3X)^2 + (y(agent, 2)-CENTROID3Y)^2)^(1/2);

    %inverse distances
    iD1 = 1/distance1;
    iD2 = 1/distance2;
    iD3 = 1/distance3;
    totalID = iD1+iD2+iD3;
    
    % Compute weighted profit for each agent
    normD1 = (iD1/totalID);
    normD2 = (iD2/totalID);
    normD3 = (iD3/totalID);
    
    % Calculate the weighted sum of the profits based on distance to centroids
    agentProfit = normD1*PROFIT1 + normD2*PROFIT2 + normD3*PROFIT3;
    
    % Store the calculated profit
    profitMatrix(agent, 1) = agentProfit; 
end

% Find the leader with the highest profit
for agent = 1:nAgents
    if profitMatrix(agent, 1) > highestProfit
        highestProfit = profitMatrix(agent, 1);
        leader = agent;
    end
end 

% Relative profit calculations
for agent = 1:nAgents
    profitMatrix(agent, 2) = profitMatrix(agent, 1) - profitMatrix(leader, 1);
    totalProfitDelta = totalProfitDelta + profitMatrix(agent, 2);
end

% Check for zero division error
if totalProfitDelta == 0
    profitMatrix(:, 3) = 0; % No movement if no relative profit difference
else
    for agent = 1:nAgents
        profitMatrix(agent, 3) = profitMatrix(agent, 2) / totalProfitDelta;
    end
end

end
