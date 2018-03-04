function [cost_E] = Elev_Cost_Function(E)
%HELPER FUNCTION:
%Elev_Cost_Function Function creates a cost_E that uses the concept of
%Floyd Warshall Algorithm but slightly different:
%http://www.geeksforgeeks.org...
%/dynamic-programming-set-16-floyd-warshall-algorithm/

%INPUT: E = Elevation matrix
%OUTPUTS: cost_E = Elevation cost matrix
%AUTHOR: Eric Leung

[R,C] = size(E); %Stating rows and columns of E matrix

%Stating cost_E initially as infinite in order to compare to unvisited
%elements and visited elements
cost_E = inf(R,C);
cost_E(:,1) = 0;

%Nest for loop that deals with rows for each column
for i = 1:C-1
    for j = 1:R    
        %Stating startPosition and running Pick_BestPath Function
        startPosition = [j,i];
        [Points,newPositions] = Pick_BestPath(startPosition, E);
        
        %If condition that considers if newPositions matrix has an element
        %with 0 or more than R (eg R = 5). First values will be removed
        if newPositions(1,1) == 0
            newPositions(1,:) = [];
        elseif newPositions(3,1) > R
            newPositions(3,:) = [];
        end
        
        %If length of Points = 2 otherwise skip condition
        if length(Points) == 2
            
            %For loop that deals with finding cost and finding its
            %difference and also updating it on the cost_E matrix
            for k = 1:2
  
                %Cost is defined by given points and previous movement from
                %E array at startPosition. Will be used for cost_E matrix
                cost = abs(Points(k) - ...
                    E(startPosition(1),(startPosition(2))));
                
                %If the already cost in cost_E is bigger than dynamic cost
                %then replace it
                if cost_E(newPositions(k,1),newPositions(k,2))...
                        - cost_E(startPosition(1),startPosition(2)) > cost
                    
                    %Put the value of sum of costs in current cost and
                    %before cost movement and update it within cost_E
                    %matrix
                    cost_E(newPositions(k,1),newPositions(k,2)) = cost ...
                        + cost_E(startPosition(1),startPosition(2));
                end
            end
        end
        
        %If length of Points = 3 otherwise skip condition
        if length(Points) == 3
            
            %For loop that deals with finding cost and finding its
            %difference and also updating it on the cost_E matrix
            for k = 1:3
                
                %Cost is defined by given points and previous movement from
                %E array at startPosition. Will be used for cost_E matrix
                cost = abs(Points(k) - ...
                    E(startPosition(1),(startPosition(2))));
                
                %If the already cost in cost_E is bigger than dynamic cost
                %then replace it
                if cost_E(newPositions(k,1),newPositions(k,2))...
                        - cost_E(startPosition(1),startPosition(2)) > cost
                    
                    %Put the value of sum of costs in current cost and
                    %before cost movement and update it within cost_E
                    %matrix
                    cost_E(newPositions(k,1),newPositions(k,2)) = cost ...
                        + cost_E(startPosition(1),startPosition(2));
                end
            end
        end
    end
end

end

