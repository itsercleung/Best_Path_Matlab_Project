function [smallestPosition] = FindSmallestElevationChange(currentPosition,r)
%FindSmallestElevationChange function uses inputs of currentPosition of
%array and 1D array 'r'. Then computes each element of the 'r' array in
%order to find the change in elevation. Using smallestPosition it then
%finds the minimum change of 'x' array and stores the number
%INPUTS: currentPosition = current position of the array destination
%        r = specified 1D array
%OUTPUT: smallestPosition = stored value of smallest element(s) in array
%AUTHOR: Eric Leung

%Stating initial A and smallestPosition array placements
elevDifference = [];
smallestPosition = [];

%For loop that repeats for every possible elevation of 'r'
for i = 1:length(r)
    %Find difference (always +ve)
    elevDifference = [elevDifference, abs(currentPosition - r(i))];
end

C = min(elevDifference); %Only considering for the smallest A value

%For 1 to length of elevation difference (expected 1,2 elements in the 1D
%array) only store the first value
for j = 1:length(elevDifference) 
    %If condition that only inputs stores numbers in smallestPosition if
    %they meet elevation difference of C
    if elevDifference(j) == C
        
        %smallestPosition is the smallest position that is decided within
        %the given r 1D array
        smallestPosition = [smallestPosition, j];
    end
end