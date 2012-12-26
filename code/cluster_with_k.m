function clusterized = cluster_with_k(matx, clust, k)
% Devuelve el k-esimo cluster. Toma los datos de matx y los relaciona con la informacion del clustering en clust.

indexes = find(clust == k);
clusterized = matx(indexes, 1:end);

end

