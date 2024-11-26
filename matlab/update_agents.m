
function [y1, A, leader] = update_agents(y0, profitMatrix, dt)
%{
Inputs:
- y0: n x 2 array, current positions of agents.
- profitMatrix: n x 1 array, profits of each agent (used to identify the leader).
- dt: timestep.

Outputs:
- y1: n x 2 array, updated positions of agents.
- A: n x n adjacency matrix (leader communicates with all).
- leader: index of the current leader.
%}

nAgents = size(y0, 1);  % Number of agents

% Find the leader based on the highest profit
[~, leader] = max(profitMatrix(:, 1));  % Get index of the agent with the highest profit
leaderPosition = y0(leader, :);  % Current position of the leader

% Initialize outputs
y1 = y0;  % Copy initial positions
A = zeros(nAgents, nAgents);  % Initialize adjacency matrix
A(leader, :) = 1;  % Leader communicates with all agents
A(:, leader) = 1;  % All agents communicate with the leader

% Move agents toward the leader
for agent = 1:nAgents
    if agent ~= leader
        % Calculate movement direction towards the leader
        moveDirection = leaderPosition - y0(agent, :);  % Vector pointing to leader
        moveStep = 1 * (dt);  % Adjust this to control speed
        y1(agent, :) = y0(agent, :) + moveStep * (moveDirection / norm(moveDirection));  % Normalize movement
    end
end
end
