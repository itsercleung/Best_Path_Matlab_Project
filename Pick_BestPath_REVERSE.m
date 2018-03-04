function [Points,newPositions] = Pick_BestPath_REVERSE(startPosition, E)
%HELPER FUNCTION:
%Greedy Pick function uses starting position, direction and 2D array(E) to
%find the best next possible step and its co-ordinates in array Pick.
%INPUTS: startPosition = 2 element, 1D array of current Position on array
%        direction = stating initial direction (1 = east, -1 = west)
%        E = 2D array for pick movement
%OUTPUTS: Pick = Smallest step coordinates in E array
%AUTHOR: Eric Leung

%For loop to manage both directions and making new positions (1D arrays)
for i = 1:3
    %state new positions for each possible reversed movement
    newPositions(i,:) = [startPosition(1)-2+i startPosition(2)-1];
    X = newPositions(:,1); %Stored newPositions(1) into X
    Y = newPositions(:,2); %Stored newPositions(2) into Y
end

%For loop and conditions that assign for the points - in terms of when
%array position is above or below the maximum height of 'E' 2D array
size1 = size(E);
if X(3) > size1(1)
    X(3) = []; %Remove elements of X and Y at element 3
    Y(3) = [];
    
    %For loop that deals with making on 2 elements for Points array
    for k = 1:2
        Points(k,:) = [E(X(k),Y(k))];
    end
elseif X(1) == 0
    X(1) = []; 
    Y(1) = [];
    
    %For loop that deals with making on 2 elements for Points array
    for l = 1:2
        Points(l,:) = [E(X(l),Y(l))];
    end
else
    
    %For loop that deals with making on 3 elements for Points array
    for i = 1:3
        Points(i,:) = [E(X(i),Y(i))];
    end
end

end