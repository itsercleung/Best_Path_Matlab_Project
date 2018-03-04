function [pathRow,pathCol,pathElev] = BestGreedyPathHeadingEast(E)
%BestGreedyPathHeadingEast function uses the greedy path concept to find
%the best possible (greedy) lowest elevation cost and will output its
%pathRow, pathCol and pathElevation difference.
%INPUT: E = 2D array for movement
%OUTPUTS: pathRows = path of rows the greedy function takes
%         pathCols = path of cols the greedy function takes
%         pathElev = path of elevations the greedy function takes
%AUTHOR: Eric Leung

[R,~] = size(E); %Stating R size of 'E' 2D array

%For loop that goes through 'R' number of rows in the 'E' 2D array
for i = 1:R 
    direction = 1; %path starts at East side
    sPosition = [i,1]; %'i' number of startPositions at east border 'E'
    
    %Stating 'pathRows','pathCols','elevation','cost' from stated functions
    [Rows(i,:),Cols(i,:)] = GreedyWalk(sPosition, direction, E);
    [Elev(i,:),cost(i)] = FindPathElevationsAndCost(Rows(i,:),Cols(i,:),E);
end

%For loop that finds the minimum cost in cost array and stores position
for i = 1:length(cost)
    %If cost of (i) meets to the defined minimum of cost array then stored
    %that value into positionCost
    if cost(i) == min(cost)
        positionCost(i) = i; %Store position costs as i values in for loop
        positionCost(:,all(~positionCost,1)) = [];%Removes all non 0 vals
        XpositionCost = positionCost(1); %Choose first position min cost
    end 
end

%Outputs of 'pathRow','pathCol' and 'pathElev' in 1D arrays from
%'XpositionCost' variable
pathRow = [Rows(XpositionCost,:)]; %Best greedy path row from west
pathCol = [Cols(XpositionCost,:)]; %Best greedy path col from west
pathElev = [Elev(XpositionCost,:)]; %Best greedy path elev from west

end