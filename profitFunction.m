function profitMatrix = profitFunction(y)
profitMatrix = zeros(NAGENTS, 1);
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

end