function res = graphic_waveforms(data, clusters, siz)

for i=1:siz,
subplot(siz,1,i), plot(cluster_with_k(data, clusters, i)')
end

end
