me=nanmean(data);
desv=nanstd(data);

umbral=me+3*desv;

spk=find(data>umbral);

colitaDeSpike = nan(length(spk), 1);
for i=1:length(spk)-1
	if spk(i+ 1) ~= spk(i) +1
		colitaDeSpike(i) = 1;
end
end

anchoMuestra = 64;
spikesCentrados = nan(nansum(colitaDeSpike), anchoMuestra);

fila = 1;
for j=1:length(spk)
	if isnan(colitaDeSpike(j)) == 0
		spikesCentrados(fila,:) = data (spk(j)-32:spk(j)+31);
		fila = fila + 1;
end
end

plot(spikesCentrados','DisplayName','spikesCentrados','YDataSource','spikesCentrados');
