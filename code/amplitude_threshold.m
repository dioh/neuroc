function a_th = amplitude_threshold(data, sr, quota)

dims = size(data)
length = dims(2)/ sr
m = reshape(data, sr, length);
int_vals = zeros(sr,length);

size(m)

mean_v = mean(m');
std_v = std(m');
count = 0;

for i=1:length;
	if(max(m(i,:)) >= quota | min(m(i,:)) <= -quota)
		int_vals(i,:) = m(i,:);
		count = count + 1;
	end
	%indexes = find( -abs(mean_v(i) - (std_v(i) * quota)) < m(i,:) & m(i,:) < abs(mean_v(i) - ( std_v(i) * quota)));
	%size(indexes)
	%a_th(i, indexes) = m(i, indexes);
end;

count

non_zero = find(int_vals(:,1) ~= 0);
a_th = int_vals(non_zero,:);

end
