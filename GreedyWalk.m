function [pathRows,pathCols] = GreedyWalk(startPosition, direction, E)
%Greedy Walk function uses continous function GreedPick in order to decide
%where to move in terms of the greedy function concept after each
%startPosition is updated until it reaches its last column
%INPUTS: startPosition = 2 element, 1D array of current Position on array
%        direction = stating initial direction (1 = east, -1 = west)
%        E = 2D array for movement
%OUTPUTS: pathRows = path of rows the greedy function takes
%         pathCols = path of cols the greedy function takes
%AUTHOR: Eric Leung

[~,C] = size(E); %Stating C size of 'E' 2D array

%Defining max rows and cols of 'E' matrix and initially putting starting
%values of pathRows and pathCols
%Using if conditions depending on direction in order to state how many
%steps to move (X_cols)
if direction == 1
    X_cols = C-startPosition(2)+1; %X_Cols = steps to move in column [EAST]
else
    X_cols = startPosition(2); %X_Cols = steps to move in column [WEST]
end

%For loop for max cols of 'E' matrix and repeats GreedyPick function while
%also updating pathRows and pathCols and startPosition variables.
for i = 1:X_cols
    %create greedy picked pathRows and pathCols from
    %startPositions(row,col)
    pathRows(:,i) = startPosition(1); %pathRows for 1st element
    pathCols(:,i) = startPosition(2); %pathCols for 2nd element
    
    if i < X_cols
        %Running GreedyPick function to reupdate startPosition for i times
        [startPosition] = GreedyPick(startPosition, direction, E);
    end
end

end