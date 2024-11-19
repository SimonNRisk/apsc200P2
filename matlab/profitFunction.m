function profitMatrix = profitFunction(y)
profitMatrix = zeros(NAGENTS, 3);
highestProfit = 0;
leader = 0;
totalProfitDelta = 0;
for agent = 1:NAGENTS
    %calculate profit per agent
    distance1 = ((y(agent, 1)-CENTROID1X)^2 + (y(agent, 2)-CENTROID1Y)^2)^(1/2);
    distance2 = ((y(agent, 1)-CENTROID2X)^2 + (y(agent, 2)-CENTROID2Y)^2)^(1/2);
    distance3 = ((y(agent, 1)-CENTROID3X)^2 + (y(agent, 2)-CENTROID3Y)^2)^(1/2);

    normD1 = distance1/(distance1+distance2+distance3);
    normD2 = distance2/(distance1+distance2+distance3);
    normD3 = distance3/(distance1+distance2+distance3);

    agentProfit = normD1*PROFIT1 + normD2*PROFIT2 + normD3*PROFIT3;
    
    profitMatrix(agent, 1) = agentProfit; %whatever value was calculated
end

for agent = 1:NAGENTS
    if profitMatrix(agent, 1) > highestProfit
        highestProfit = profitMatrix(agent, 1);
        leader = agent;
    end
end

for agent = 1:NAGENTS
    profitMatrix(agent, 2) = profitMatrix(leader, 1) - profitMatrix(agent, 1);
    totalProfitDelta = totalProfitDelta + profitMatrix(agent, 2);
end

for agent = 1:NAGENTS
    profitMatrix(agent, 3) = profitMatrix(agent, 2) / totalProfitDelta;
end

end