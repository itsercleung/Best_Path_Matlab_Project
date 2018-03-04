function [r] = Reverse(row)
%Taking a 1D array and using reverse function equation of 
%(row(length(row)-i+1). EX r = (1,2,3,4,5) -> R = (5,4,3,2,1)
%INPUT: row - 1D array
%OUTPUT: r - reversed 1D array
%AUTHOR: Eric Leung

%Transposing input row and defining C(Cols) for size of transposed row
transposed_row = row';
[~,C] = size(transposed_row);

%If condition that seperates if a Row is a column vector or a row vector. 
%Eg. If transposed row has C = 1 then it is a row vector!
if C == 1
    %For loop with uses the R equation for every position of the r array.
    %Thus reversing the placement of each value in the r array.
    for i = 1:length(row)
        r(i) = row(length(row) - i + 1); %r = reversed of input row
    end
    
elseif C ~= 1
    %For loop with uses the R equation for every position of the r array.
    %Thus reversing the placement of each value in the r array.
    for i = 1:length(row)
        r(i) = row(length(row) - i + 1); %r = reversed of input row
        r = r'; %transpose r since it is a column vector
    end
end
