
%% HEADER 
%{
APSC 200 MODULE P2 - MTHE - CONSENSUS ALGORITHM TEMPLATE
Author: S. Dougherty, Math & Eng., Queen's University
Release Date: 2022-11-08

Inputs:     consensus_input.csv = initial values for all agents
Outputs:    consensus_output.csv = time vs state data
            consensus_output.mat = time, state and network data 
                           (req'd for annimation)
            Time vs state and arena plots

Functions (user-defined):   leader.m
                            consensus_adjacency_matrix.m
                            consensus_filter.m
                            update_agents.m
                            profitFunction.m

The I/O descriptions can be found in the preamble of each function.

animate_network.m generates a visualization of the network over the course
of this simulation.  It can only be run once this script has been
successfully executed.

--- Revision History ---
2022-10-19: Initial release
2022-11-08: Fixed consensus filter initialization for formation w leader

***************************************************************************
This script simulates the consensus algorithm outlined in the APSC 200 MTHE 
Course Manual. The script has been designed with transparency in mind.
(i.e., It allows you to see how all of the pieces fit together.) 

For this script to execute successfully, two tasks must be completed:
1: All of the functions listed above must be built.
2: The simulation parameters (marked by UPPERCASE letters) and the initial 
   values (specified in consensus_input.csv) must be updated to match your
   application. 

Advanced users are welcome to alter this script to meet their needs; 
however, it will be done at their own risk. (i.e., Do not rely on the
instructor/TAs to help with large structual modifications to this script.)
***************************************************************************
%}

%% PARAMETERS - can edit w/o comprimising script execution

% simulation parameters
TFINAL = 50;
NSTEPS = 50;

% agent parameters
K = 4;
RANDOM_AGENTS = 0;  % # of randomly generated agents scattered on [-K,K]^2
                    % if = 0, then positions at t = 0 are given by
                    % consensus_input.csv

FLOCKING_SYSTEM = 1;
% if 0 = formation/rendezous, 1 = flocking

LEADER_SYSTEM = 1;
% if 0 = no leader, 1 = leader, not influenced by network

%INIT_ENERGY = 100;      % initial "energy" stored in each agent

% plot toggles - set to 0 to suppress plot
SHOW_ARENA = 1;         % 2D plot showing agent paths
SHOW_OUTPUT = 1;        % output vs time plot
SHOW_CONSENSUS = 1;     % consensus state vs time plot
SHOW_ENERGY = 0;        % energy vs time plot


% additional global variables?
CENTROID1X = 0;   % X-coordinate of centroid for Algorithm 1
CENTROID1Y = 0;   % Y-coordinate of centroid for Algorithm 1

CENTROID2X = 10;   % X-coordinate of centroid for Algorithm 2
CENTROID2Y = 0;   % Y-coordinate of centroid for Algorithm 2

CENTROID3X = 5;  % X-coordinate of centroid for Algorithm 3
CENTROID3Y = 8.66;   % Y-coordinate of centroid for Algorithm 3

PROFIT1 = 0;   % Profit rate for Algorithm 1
PROFIT2 = 0;   % Profit rate for Algorithm 2
PROFIT3 = 0;   % Profit rate for Algorithm 3
%% REMEMBER: IVE JUST MADE THESE UP

%profitMatrix = profitFunction(currentAgentPositions, CENTROID1X, CENTROID1Y, CENTROID2X, CENTROID2Y, CENTROID3X, CENTROID3Y, PROFIT1, PROFIT2, PROFIT3);

%% SETUP

% importing initial values -----------------------------------------------
if (RANDOM_AGENTS == 0)
    initval = readmatrix('consensus_input.csv');  
    nagents = length(initval);
else
    nagents = RANDOM_AGENTS;
    initval = nan(nagents,2);
    initval(:,1) = K * (2*rand(nagents,1) - 1);
    initval(:,2) = K * (2*rand(nagents,1) - 1);
    
    % The following two lines initialize the consensus states with the
    % agent's initial output value. This may not always be suitable. 
    initval(:,3) = initval(:,1);
    initval(:,4) = initval(:,2);
end

%read .csv of profit values calculated from algorithms
algoProfit = readmatrix('test_profit_input.csv');

% pre-allocation & initialization -----------------------------------------
P = nan(NSTEPS, nagents, 2);        % all output data 
for i = 1:2
    P(:,:,i) = ones(NSTEPS,1) * initval(:,i)';
end
% P(i,j,k) is agent-j's k-th output at the i-th timestep; k = {1,2}

Q = nan(NSTEPS, nagents, 2);         % all consensus state data
for i = 1:2
    Q(:,:,i) = ones(NSTEPS,1) * initval(:,i+2)';
end
% same structure as P but for consensus state

Pdot = zeros(NSTEPS, nagents, 2);
% same structure as P but for time derivative of output

%E = INIT_ENERGY * ones(NSTEPS,nagents);     % all energy data
% E(i,j) is agent-j's energy at the i-th timestep

G = nan(nagents, nagents, NSTEPS-1);  % all network data
% G(:,:,i) is the Laplacian matrix at the i-th timestep


%% SIMULATION
t = linspace(0, TFINAL, NSTEPS)'; 
tstep = t(2);

save_head = 1;   

P = nan(NSTEPS, nagents, 2);  % Store positions for all agents at each timestep
P(1, :, 1) = initval(:, 1);  % x positions
P(1, :, 2) = initval(:, 2);  % y positions

%% MAIN BODY OF CODE
%% SIMULATION
for i = 1:NSTEPS-1
    % Current positions of all agents at timestep i
    currentAgentPositions = squeeze(P(i, :, :));  % Get positions at timestep i (x and y)

    %update profit from each algorithm for time step
    PROFIT1 = algoProfit(i,1);
    PROFIT2 = algoProfit(i,2);
    PROFIT3 = algoProfit(i,3);

    % Step 1: Calculate profits for all agents
    profitMatrix = profitFunction(currentAgentPositions, ...
                                   CENTROID1X, CENTROID1Y, ...
                                   CENTROID2X, CENTROID2Y, ...
                                   CENTROID3X, CENTROID3Y, ...
                                   PROFIT1, PROFIT2, PROFIT3);

    % Step 2: Update agent positions and determine the leader dynamically
    [p1, G(:,:,i), leader] = update_agents(currentAgentPositions, profitMatrix, tstep);

    % Save the updated positions for plotting
    P(i+1, :, :) = p1;

    % (Optional) Save the leader index for tracking (if needed for analysis/visualization)
    leaders(i) = leader;
end


%% PLOTTING
if (SHOW_ARENA)
    my_colours = ["#FF0000", "#00FF00", "#0000FF", "#00FFFF", ...
    "#FF00FF", "#FFFF00", "#0072BD", "#D95319", "#EDB120", ...
    "#7E2F8E", "#77AC30", "#4DBEEE", "#A2142F"];

    figure 
    hold on
    
    % text offset for agent index
    tos = 0.01*[max(P(:,:,1),[],"all") max(P(:,:,1),[],"all")]; 

    for i=1:nagents
        % start = agent index
        clr = my_colours(mod(i,length(my_colours))+1);  
        text(P(1,i,1)+tos(1), P(1,i,2)+tos(2), ...
            num2str(i), 'Color', clr);     

        % agent path
        plot(P(:,i,1), P(:,i,2), "Color", clr);       

        % end = star
        plot(P(end,i,1), P(end,i,2), "Marker", "pentagram",... 
            "Color",clr,"MarkerFaceColor",clr);         
    end
    xlabel("p1");
    ylabel("p2");
    hold off
end

legend_labels = cell(nagents,1);
for i = 1:nagents
    legend_labels{i} = strcat("agent ", num2str(i));
end

if (SHOW_OUTPUT)    
    figure
    subplot(211)
    plot(t, P(:,:,1))
    title("Output")
    xlabel("t")
    ylabel("p1")
    legend(legend_labels);
    
    subplot(212)
    plot(t, P(:,:,2))
    xlabel("t")
    ylabel("p2")
end

if (SHOW_CONSENSUS) 
    figure
    subplot(211)
    plot(t, Q(:,:,1))
    title("Consensus State")
    xlabel("t")
    ylabel("q1")
    legend(legend_labels);
    
    subplot(212)
    plot(t, Q(:,:,2))
    xlabel("t")
    ylabel("q2")
end

if (SHOW_ENERGY)
    figure
    plot(t,E)
    xlabel("t")
    ylabel("Energy")
    legend(legend_labels);
end

%% EXPORTING DATA

% --- Matlab - for arena animation ---
save("consensus_output.mat", "t", "P", "G");  

% --- Excel/Other - for further analysis ---
p1_ = P(:,:,1);
p2_ = P(:,:,2);
q1_ = Q(:,:,1);
q2_ = Q(:,:,2);
output_table = [array2table(t) array2table(p1_) array2table(p2_) ...
    array2table(q1_) array2table(q2_)];
writetable(output_table,"consensus_output.csv"); 

%{
***************************** CSV headers ******************************
You will notice the headers in the output csv are a awkward to read.
Lets take "q2_5" as an example:
  2 - indicates it is the second element (y dir) of the consensus state
  5 - indicates that this for agent 5
%}
