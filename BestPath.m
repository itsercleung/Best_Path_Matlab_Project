function [pathRow,pathCol,pathElev] = BestPath(E)
%BestPath Function uses inputs elevation 'E' and finds the best possible
%path using A star (A*) algorithm as a base found from:
%http://theory.stanford.edu/~amitp/GameProgramming/MapRepresentations.html
%INPUTS: E = 2D Elevation Matrix
%OUTPUTS: pathRow = Best Path row
%         pathCol = Best Path column
%         pathElev = Best path elevation
%AUTHOR: Eric Leung

%NOTE: Due to extremely small decimals not being able to compare each other
%with '==' sign, must bump up decimals and round.
E = E.*1000000; %Bump up decimals by max of E matrix
E = round(E); %Round E matrix by 1 point

%Stating size of row and cols of E matrix
[R,C] = size(E);

%Using function 'Elev_Cost_Function' to find cost_E of E matrix
[cost_E] = Elev_Cost_Function(E);

min_cost_E = min(cost_E(:,C)); %minimum cost of cost_E in every column
[row,col] = find(cost_E(:,C) == min_cost_E); %finding min_cost_E row & col
col = col + C - 1; %Since col can differ change it appropriately
startPositions = [row,col]; %Stating initial startPositions of row & col

%Stating initial variables and arrays beforehand

startPosition = startPositions(1,:); %stating initial (top) startPosition
pathCol_REVERSED = []; %Stating initial array for reversed path of Cols
pathCol_REVERSED = startPositions(1,2);%Stating first reversed value of Col
pathRow_REVERSED = [];
pathRow_REVERSED = startPositions(1,1);
pathElev_REVERSED = [];
pathElev_REVERSED(1) = E(startPosition(1),startPosition(2));

%For loop that continues to loop for every column except of C = 1
for j = C:-1:2
    flag = 0; %Flag (for loop) that if the condition is met then break!
    
    %Using function 'Pick_BestPath_REVERSE' for both cost_E & E matrix
    [Points_E,newPositions_E] = Pick_BestPath_REVERSE(startPosition, E);
    [Points_cost,~] = Pick_BestPath_REVERSE(startPosition, cost_E);
    
    %Compare_E is the absolute value of difference between Points_E and E
    %from current startPosition. Used to find differences of smallest elev
    Compare_E = abs(Points_E - E(startPosition(1),startPosition(2)));
    
    %Compare_cost is the absolute value of difference between Points_E and
    %cost_E matrix from current startPosition. Used to find differences of
    %smallest elev
    Compare_cost = abs(Points_cost - ...
        cost_E(startPosition(1),startPosition(2)));
    
    %If newPositions from 'Pick_BestPath_REVERSE' function has '0' or Rows
    %(eg R = 5). Its first values then get rid of the array spot
    if newPositions_E(1,1) == 0
        newPositions_E(1,:) = [];
    elseif newPositions_E(3,1) > R
        newPositions_E(3,:) = [];
    end
    
    %For loop that deals with the whole length of variable Points_cost
    for k = 1:length(Points_cost)
        min_cost = min(Points_cost); %min_cost for best path concept
    
        %If compare_E from above == compare_cost and Points_cost == to
        %min_cost then let the condition run, while storing for k to use
        %for future values
        if Compare_E(k) == Compare_cost(k) && Points_cost(k) >= min_cost
            
            %Condition is met: store best pathElev_reversed from the points
            %array position
            pathElev_REVERSED = [pathElev_REVERSED,Points_E(k)];
            startPosition = newPositions_E(k,:); %Update startPosition
            
            %Condition is met: store rows and cols of new startPosition
            pathRow_REVERSED = [pathRow_REVERSED,startPosition(1)];
            pathCol_REVERSED = [pathCol_REVERSED,startPosition(2)];
            
            flag = 1; %Once if statement is reached, commence break (=1)
        end
        
        %If condition for breaking for loop
        if flag == 1
            break
        end   
    end
end

%After whole for loop is run, get all of pathRow,pathCol,pathElev and
%reverse them all using 'Reverse' function. #This makes them go from left
%to right now
[pathElev] = Reverse(pathElev_REVERSED); %Best path elevation in E matrix
[pathRow] = Reverse(pathRow_REVERSED); %Best path row in E matrix
[pathCol] = Reverse(pathCol_REVERSED); %Best path column in E matrix

%Fix the bump up in order to have original path Elevation
pathElev = pathElev./1000000; %Bump down decimals by max of peak

end

