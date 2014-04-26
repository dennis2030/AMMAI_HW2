function generateUpload(dist, LFW_DATA, outfile)
   queryId = LFW_DATA.queryIdentity;
   databaseId = LFW_DATA.databaseIdentity;
   d_name = LFW_DATA.databaseName;
   q_name = LFW_DATA.queryName;
   qPts = size(queryId,1);
   nPts = size(databaseId,1);
   ap = zeros(qPts, 1);
   rankResults = zeros(qPts, nPts);
   for i = 1:qPts
      [~, idx] = sort(dist(i,:), 'ascend');
      correctRank = find(databaseId(idx) == queryId(i));
      rankResults(i,:) = idx;
      nAns = size(correctRank,1);
      for j = 1:nAns
         ap(i) = ap(i) + j/correctRank(j);
      end
      ap(i) = ap(i)/nAns;
   end

   fid = fopen(outfile, 'w');
   fprintf(fid, '%f\n', mean(ap));
   for i = 1:qPts
      fprintf(fid, '%f\n', ap(i));
      fprintf(fid, '%s\n', q_name{i});
      for j = 1:10
         fprintf(fid, '%s\n', d_name{rankResults(i, j)});
      end
   end
