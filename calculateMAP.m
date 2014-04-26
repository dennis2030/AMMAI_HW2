function [meanAveragePrecision] = calculateMAP(dist, queryId, databaseId)
% Calculate mean average precision using parwise distance matrix
% Input:    dist - m*n matrix  m: number of query images
%                           n: number of database images
%           queryId - m*1 vector
%              query identity, same value means same identity
%           databaseId - n*1 vector
%              database identity, same value means same identity
% Output:   meanAveragePrecsion - scalar, result MAP

meanAveragePrecision = 0;
sumOfAP = 0;

% get the number of rows and cols in dist
[m,n] = size(dist);


[B,index] = sort(dist,2);

% for each row(query), calc its AP(Average Precision)
for row=1:m
    numOfTP = 0;
    sumOfPrecision = 0;
    precision = zeros(m,1);

    % sort the dist vector
    for i=1:n
        % check whether the query is matched with databaseid
        if(queryId(row) == databaseId(index(row,i)) )
            numOfTP = numOfTP + 1;
            precision(i) = numOfTP/i;
            sumOfPrecision = sumOfPrecision + numOfTP/i;
        end
    end
    AP = sumOfPrecision/numOfTP;
    sumOfAP = sumOfAP + AP;
end

meanAveragePrecision = sumOfAP/m;
% Your code here
