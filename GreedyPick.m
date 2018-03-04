function [Pick] = GreedyPick(startPosition, direction, E)
%Greedy Pick function uses starting position, direction and 2D array(E) to
%find the best next possible step and its co-ordinates in array Pick.
%INPUTS: startPosition = 2 element, 1D array of current Position on array
%        direction = stating initial direction (1 = east, -1 = west)
%        E = 2D array for pick movement
%OUTPUTS: Pick = Smallest step coordinates in E array
%AUTHOR: Eric Leung

startPositions = zeros(3,2); %Preallocate startPositions

%For loop to manage both directions and making new positions (1D arrays)
for i = 1:3   
    %If direction == 1 then move to the right in columns
    if direction == 1
        newPositions(i,:) = [startPosition(1)-2+i startPosition(2)+1];
        
    %Elseif direction == -1 move columns to the left
    elseif direction == -1
        newPositions(i,:) = [startPosition(1)-2+i startPosition(2)-1];
    end
    
    %Define X and Y as the newPositions for both elements 1 & 2 columns
    X = newPositions(:,1);
    Y = newPositions(:,2);
end

size1 = size(E); %First stating size of E matrix

%If statement that assign for the points - in terms of when array position
%is above or below the maximum height of 'E' 2D array - if size of first 
%element of E matrix is less than X variable (3rd position)
if X(3) > size1(1)
    X(3) = []; %Remove elements of X and Y at element 1
    Y(3) = [];
    %For loop that deals with making on 2 elements for Points array
    for k = 1:2
        Points(k,:) = [E(X(k),Y(k))]; %Points = all possible movements on E
    end  
    
elseif X(1) == 0
    X(1) = []; %Remove elements of X and Y at element 3
    Y(1) = [];
    %For loop that deals with making on 2 elements for Points array
    for l = 1:2
        Points(l,:) = [E(X(l),Y(l))]; %Points = all possible movements on E
    end
    
else
    %For loop that deals with making on 3 elements for Points array
    for i = 1:3
        Points(i,:) = [E(X(i),Y(i))]; %Points = all possible movements on E
    end
end

%Declaring variables that will decide on smallest step and Pick 2 element
%1D array and IF smallestPosition contains two elements then only store
%first element (MOST NORTH)
currentPoint = E(startPosition(1),startPosition(2));

%Running FindSmallestElevationChange
smallestPos = FindSmallestElevationChange(currentPoint, Points);
smallestPos = smallestPos(1); %Take only 1st position

%If conditions that stops array position [0,X] from showing up
if newPositions(1) == 0
    %Pick is the best smallest elevation change coordinate to E matrix
    Pick = [newPositions(smallestPos+1,1),newPositions(smallestPos,2)];
else
    %Pick is the best smallest elevation change coordinate to E matrix + 1
    Pick = [newPositions(smallestPos,1),newPositions(smallestPos,2)];
end

end