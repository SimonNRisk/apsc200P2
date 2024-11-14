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

y(currentStep, 1) = 

end