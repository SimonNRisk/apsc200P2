function x1 = consensus_filter(x0, L, t, dt)
%{
Let "n" be the number of agents.

--- Inputs ---
x0: n by 2 array holding consensus state information for timestep i
    e.g., x0(j,1) is the first consensus state for agent-j

L:  n by n Laplacian matrix

t and dt: the current time and timestep, respectively. 

--- Outputs ---
x1: n by 2 array holding consensus state information for timestep i+1
    Same structure as x0.
%}

% Define a scaling factor for the consensus update (typically between 0 and 1)
alpha = 0.1;  % You can adjust this value based on your system

% Calculate the update rule
% x1 = x0 + alpha * L * x0 (this will update the consensus state)

% We are updating each dimension (1st and 2nd) of the consensus state
x1 = x0 + alpha * (L * x0); 

end