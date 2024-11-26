function [y, ydot] = leader(t, currentStep, agentPositions, profitMatrix)
%{
This function determines the leader's position dynamically based on 
the current agent profits. The leader is the agent with the highest profit.

--- Inputs ---
t: vector of length n holding time data (not used here directly, but 
   included for consistency with other functions).
currentStep: the current simulation step, used to update the leader's position.
agentPositions: n by 2 array holding the x and y positions of all agents at 
                  the current simulation step.
profitMatrix: n by 3 array, where the first column contains the absolute profit 
              of each agent (output from profitFunction.m).

--- Outputs ---
y: NSTEPS by 2 array holding the leader's x and y positions at every timestep.
   For each step, y(currentStep, :) represents the leader's position.
ydot: NSTEPS by 2 array holding the leader's velocity. Since the leader is 
      not moving autonomously, this remains zero.

Note: NSTEPS is a global parameter indicating the total number of timesteps.
%}

%% Preallocations for leader data
global NSTEPS
y = zeros(NSTEPS, 2);    % Leader's position: x and y
ydot = zeros(NSTEPS, 2); % Leader's velocity: x and y (always zero)

%% Identify the leader
[~, leaderIndex] = max(profitMatrix(:, 1)); % Get index of highest profit agent

% Retrieve the leader's position based on agentPositions matrix
% Ensure only the x and y positions are selected, even if agentPositions has more columns.
leaderPosition = agentPositions(leaderIndex, 1:2); % Extract only the x and y values (1x2 vector)

%% Update the leader's position for the current simulation step
y(currentStep, :) = leaderPosition;  % Store the leader's position in the y array

%% Ensure velocity remains zero
ydot(currentStep, :) = [0, 0]; % The leader's velocity is always zero (no movement).

end