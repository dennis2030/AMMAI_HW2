function distance = computeDistance(querySR, databaseSR, K)
    nPart = 80;
    nDim = 59;
    df = zeros(nPart,K,1); 
    idf = zeros(nPart,K,1);

    n = size(databaseSR,1);
    m = size(querySR,1);

    distance = zeros(m,n);

    % calculate df
    for i=1:n
        for j=1:nPart     
            startIdx = (j-1)*K+1;
            endIdx = j*K;
            mask = databaseSR(i,startIdx:endIdx)>0;
            df(j, mask) = df(j, mask) + 1;
        end
    end

    % calculate idf
    idf = log(n./df);
    
    for i=1:nPart
        startIdx = (i-1)*K+1;
        endIdx = i*K;
        databaseSR(:,startIdx:endIdx) = databaseSR(:,startIdx:endIdx)* idf(i)';
        querySR(:,startIdx:endIdx) = querySR(:,startIdx:endIdx)*idf(i)';
    end

    distance = pdist2(querySR,databaseSR,'spearman');
    %{
    % calculate cosine similarity
    for i=1:m
        for j=1:nPart
            startIdx = (j-1)*K+1;
            endIdx = j*K;            
            for k=1:n
                distance(i,k) = dot(querySR(i,startIdx:endIdx)*idf(j,:)',databaseSR(k,startIdx:endIdx)*idf(j,:)')/norm(querySR(i,startIdx:endIdx)*idf(j,:)')/norm(databaseSR(k,startIdx:endIdx)*idf(j,:)');
            end
        end
    end
    %}
end
