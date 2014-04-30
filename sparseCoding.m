function [querySR, databaseSR, D] = sparseCoding(query, database)
%% Find query and database sparse representations
% Input:    query - m*(d*p) matrix     m: number of query images
%                                      d: feature dimension for each part
%                                      p: number of parts (80 in our case)
%           database - n*(d*p) matrix  n: number of database images
% Output:   querySR - m*(k*p)          k: dictionary size
%           databaseSR - n*(k*p)
%           D - d*k*p
%              dictionaries for every parts.

% Some initial values
qPts = size(query,1);
nPts = size(database,1);
nDim = 59;
nPart = 80;
K = 60;

parD.lambda = 0.04;
parD.K = K;
parD.posD = 1;
parD.posAlpha = 1;
parD.iter = 50;
parD.verbose = 0;
parD.numThreads = 8;

parS.lambda = 0.04;
parS.K = K;
parS.pos = 1;
parS.verbose = 0;
parS.numThreads = 8;

D = zeros(nDim, K, nPart);
querySR = zeros(qPts, K*nPart);
databaseSR = zeros(nPts, K*nPart);

% Loop through each part
for i = 1:nPart
	% You code here
    % for every image in database
    % Use mexTrainDL to train dictionary for each part
    startIndex = (i-1) * nDim + 1;
    endIndex = i*nDim ;
    D(:,:,i) = mexTrainDL(database(:,startIndex:endIndex)',parD);

    startIdx_sparse = (i-1)*K+1;
    endIdx_sparse = i*K;
    databaseSR(:,startIdx_sparse:endIdx_sparse) = mexLasso(database(:,startIndex:endIndex)',D(:,:,i),parS)';
    querySR(:,startIdx_sparse:endIdx_sparse) = mexLasso(query(:,startIndex:endIndex)',D(:,:,i),parS)';

end

