function [y1, A] = update_agents(y0, ydot, x1, dt, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3)
%{
Let "n" be the number of agents.

--- Inputs ---
y0: n by 2 array holding all system outputs at timestep i
    e.g., y0(j,2) is the second output for agent-j

ydot: n by 2 array holding all system output time derivatives at timestep i
    e.g., ydot(j,2) is the second output time derivative for agent-j

x1: n by 2 array holding all consensus states for all agents at timestep i+1
    e.g., x1(j,2) is the second consensus state for agent-j

E0:  1 by n array holding energy data for all agents at timestep i
    e.g., E0(j) is the energy of agent-j at timestep i  

dt: timestep

--- Outputs ---
y1:  n by 2 array holding all system outputs at timestep i+1
     Same structure as y0.

E1: 1 by n array holding energy data for all agents at timestep i+1.
    Same structure as E0.

A:  n by n adjacency matrix indicating the communication structure, where
   only the leader communicates with the other agents.
%}

nAgents = size(y0, 1);  % Number of agents

% Initialize outputs
y1 = y0;  % Initialize updated positions to the current positions
%E1 = E0;  % Initialize updated energy levels

% Step 1: Identify the leader based on the highest profit (profitFunction is assumed to give this)
profitMatrix = profitFunction(y0, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3);  % Assuming profitFunction returns the profit for all agents
[~, leader] = max(profitMatrix(:, 1));  % Get the index of the agent with highest profit
leaderPosition = y0(leader, :);  % Leader's position

% Initialize adjacency matrix
A = zeros(nAgents, nAgents);  % Initialize adjacency matrix with zeros
A(leader, :) = 1;  % Leader row (leader talks to everyone)
A(:, leader) = 1;  % Leader column (everyone talks to leader)

% Step 2: Flocking behavior (agents move towards the leader)
for agent = 1:nAgents
    % Initialize moveDirection for each agent
    moveDirection = zeros(1, 2);  % Initialize as a zero vector
    
    if agent ~= leader
        % Calculate the movement direction towards the leader
        moveDirection = leaderPosition - y0(agent, :);  % Direction vector to leader
        % Adjust movement based on profit difference (agents with lower profit move more)
        profitDifference = abs(x1(agent, 1) - x1(leader, 1));  % Difference in profit with leader
        moveStep = 0.1 * (1 + profitDifference);  % Amount to move (larger move for smaller profit)
        
        % Update the agent's position (move towards the leader)
        y1(agent, :) = y0(agent, :) + moveStep * moveDirection / norm(moveDirection);  % Normalize movement direction
    end

    distanceMoved = norm(moveDirection);  % Calculate the distance moved

end

end
