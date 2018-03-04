function [elevation, cost] = FindPathElevationsAndCost(pathRows,pathCols,E)
%Function FindPathElevationsAndCost is a function to find elevation
%differences between given values of rows(A) and cols(B) in a walking
%path(E). It then uses elevation values to find the total cost of each
%move and stores it.
%INPUTS: A = rows of travel
%        B = cols of travel
%OUTPUTS: elevation = elevation of 1 point to the other on E
%         cost = total cost of travel between 1 point to the other
%AUTHOR: Eric Leung

%Declaring variables and array setup
elevation = [];
cost = 0;

%For loop using rows(A) and cols(B) to find co-ordinate points on E
for i = 1:length(pathRows)
    %Elevation is the value how for much the path of Rows and Cols take
    elevation = [elevation,E(pathRows(i),pathCols(i))];  
end

%For loop using elevation differences to find the total cost of travel
%(NOTE = absolute values of differences)
for j = 1:length(elevation) - 1
    %Cost is the overall cost of the path: including original cost plus the
    %absolute value of elevation differences
    cost = cost + abs(elevation(j) - elevation(j+1));
end

end