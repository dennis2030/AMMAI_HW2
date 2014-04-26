function distance = l2Distance(X1, X2)
% Compute pairwise L2 distance between two matrix
% Input: X1 - m*d matrix   m: number of images in query
%                          d: feature dimension
%        X2 - n*d matrix   n: number of images in database
% Output: distance - m*n matrix

distance = zeros(size(X1,1), size(X2,1));

% Your code here

% get the number of rows and cols 
[m,dX] = size(X1);
[n,d] = size(X2);

distance = pdist2(X1,X2,'euclidean');

end
