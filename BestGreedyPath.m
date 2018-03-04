function [pathRow,pathCol,pathElev] = BestGreedyPath(E)
%BestGreedyPath Function finds the best greedy path by calculating every
%greedy path walk with every element in the 'E' array. It then outputs the
%BEST (lowest cost) path of row, path of column and path of elevation.
%INPUTS: E = 2D array for movement
%OUTPUTS: pathRows = path of rows the greedy function takes
%         pathCols = path of cols the greedy function takes
%         pathElev = path of elevations the greeyd function takes
%AUTHOR: Eric Leung

%Intially stating Rows number and Cols number of 'E' array
[R,C] = size(E);

%Initially calling the size of cost arrays (east, west and total)
arraycostEast = zeros(R,C);
arraycostWest = zeros(R,C);

%Nested for loop that deals with each Column for every Row in order to go
%through all of the elements in the 'E' array
for i = 1:R
    for j = 1:C
        startPosition = [i,j]; %StartPosition for every i,j in for loops
        for direction = 1:-2:-1
            %Using 'Greedy Walk' Function and 'FindPathElevationsAndCost'
            %Function to overall find cost!
            [pathRow,pathCol] = GreedyWalk(startPosition, direction, E);
            [~,cost] = FindPathElevationsAndCost(pathRow,pathCol,E);
         
            if direction == 1
                arraycostEast(i,j) = cost; %EAST cost array
            elseif direction == -1
                arraycostWest(i,j) = cost; %WEST cost array
            end 
        end
    end
end

%Total cost of EAST AND WEST array
total_arraycost = arraycostEast + arraycostWest;

%Transposing Total cost array in order to find minimum cost inside
%total_arraycost
transposed_total_arraycost = total_arraycost';
[minCost,~] = min(transposed_total_arraycost(:));

%Nested for loop that uses minCost to find the position (row and column) of
%where the FIRST minCost shows up throughout the total_arraycost then
%states the BestGreedyPath element startPosition (row,col) of 'E'

flag = 0; %Flag allows for the nested for loop to BREAK when necessary

for m = 1:R
    for n = 1:C 
        %If condition deals with finding first minCost and putting it m & n
        %values into startPosition.
        if minCost == total_arraycost(m,n)
            startPosition = [m,n];
            flag = 1; %Once if statement is reached, commence break (=1)
            break
        end
    end
    
    %If condition for breaking for loop
    if flag == 1
        break
    end
end

%For loop that reruns the functions 'GreedyWalk' and
%'FindPathElevationsAndCost' but only using the proper startPosition that
%meets the BESTGREEDYPATH criteria
for direction = 1:-2:-1
    %Using both functions with the new StartPosition to find the final best
    %greedy path
    [pathRow,pathCols] = GreedyWalk(startPosition, direction, E);
    [pathElev,~] = FindPathElevationsAndCost(pathRow,pathCols,E);
    
    %If condition that sorts best rows,cols and elevations into west & east
    if direction == 1
        stored_RowEast = pathRow; %Stored row to East side
        stored_RowEast(1) = []; %Banish (1) array to stop repeats of West
        stored_ColEast = pathCols;
        stored_ColEast(1) = [];
        stored_ElevEast = pathElev;
        stored_ElevEast(1) = [];
    else
        stored_RowWest = pathRow; %Stored row to west side
        stored_ColWest = pathCols;
        stored_ElevWest = pathElev;
        [stored_RowWest] = Reverse(stored_RowWest); %Reverse west side row
        [stored_ColWest] = Reverse(stored_ColWest);
        [stored_ElevWest] = Reverse(stored_ElevWest);
    end
end

%Final combination of all the stated stored rows,cols and elevations into
%packed OUTPUT variables
pathRow = [stored_RowWest,stored_RowEast];
pathCol = [stored_ColWest,stored_ColEast];
pathElev = [stored_ElevWest, stored_ElevEast];

end