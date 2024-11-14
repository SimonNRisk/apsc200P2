function A = consensus_adjacency_matrix(y)
%{
Let "n" be the number of agents.

--- Inputs ---
y: n by 2 array holding output data for all agents
   e.g., y(j,2) is the second output for agent-j

--- Outputs ---
A:  n by n adjacency matrix - see notes for details on construction
%}

profitMatrix = profitFunction(y);

for agent = 1:NAGENTS
    highest = 0;
    leader = 1;
    if profitMatrix(agent, 1) > highest
        highest = profitMatrix(agent, 1);
        leader = agent;
    end
end

A = zeros(NAGENTS, NAGENTS);
for index = 2:NAGENTS
    A(index, 1) = 1;
    A(1, index) = 1;
end

end