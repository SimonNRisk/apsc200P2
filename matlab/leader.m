function [y, ydot] = leader(t, currentStep)
%{
Let "n" be the length of the time vector

--- Inputs ---
t: vector of length n holding time data

--- Outputs ---
y: n by 2 array holding the leader's output data. e.g., x(:,1) is all of
   the output data for the leader's first output. 

ydot: n by 2 array holding the leader's output time derivative data. 
      e.g., if y is postion then, ydot(:,1) is all of the leader's velocity
      data for the first output
%}
y = zeros(NSTEPS, 2);
ydot = zeros(NSTEPS, 2);

%% TO DO:
%{ 
     - change leader function to update every iteration
     - need more inputs: calculate which agent is the leader (need position
    matrix to calculate profit, profit matrix to determine which agent has
    highest profit)
     - need to update leader through each iteration to change position
     vector to match correct agent
     - velocity array should stay at 0 since leader is not moving
     - 
%}

y(currentStep, 1) = 

end