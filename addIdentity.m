function databaseSR = addIdentity(databaseSR, databaseId)
    databaseSet = unique(databaseId);
    lambda = 0.5
    for i=1:length(databaseSet)
        mask = databaseId ==  databaseSet(i);
        meanSR = mean( databaseSR(mask,:), 1);        
%        size(meanSR)
%        disp('====ones====')
%        size( ones(sum(mask),size(meanSR,2)) )
%        disp('====meanSR====')
        databaseSR(mask,:) = databaseSR(mask,:)*lambda + ones(sum(mask),1)*meanSR*(1-lambda);
    end
        

end
