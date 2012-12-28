function m = full_sort(d)
	m = [];
	for i = 1:length(d.data) / d.par.sr;
		st = (i - 1) * d.par.sr + 1;
		ed = i * d.par.sr;
		st
		ed
		m2 = spike_detect(d.data, d.par.sr, st, ed, true);
		size(m)
		size(m2)
		m = [m;m2];

	end;
	plot(m');
end
