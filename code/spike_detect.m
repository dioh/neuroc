function m = spike_detect(data, sr)

m = []; 

d_v = data;
me = mean(d_v);
st = std(d_v);
th = me + 3*st ;

% Window size is divided in two, 1ms for the start potential, 1.5 ms for the remining after the peak.
spk_dur = 2.5;
b_peak = 1 * sr / 1000; 
a_peak = 1.5 * sr / 1000; 
wsize =  b_peak + a_peak;


%% Filtro por threshold
val_uth = find( d_v >= th) ;

%% Busco maximo por intervalo de a wsize mediciones (2ms por spike a 24khz son 48 observaciones) 
%for i=1:2;
for i=1:(length(d_v ) - wsize)/ wsize;
	s_i = i * wsize ; % Window start index
	e_i = (i + 1) * wsize  ; % Window end index
	c_win = d_v(s_i : e_i); 
	[e, i] = max(c_win); % This is the pivot of the window, the centroid of the spike.

	abs_i = i + s_i; % Max value absolute position

	%b_peak
	%a_peak
	%abs_i
	abs_st_i = max(abs_i - b_peak, 1);
	abs_e_i = min(abs_i + a_peak, length(d_v));

	m(end + 1,:) = d_v(abs_st_i: abs_e_i) ;

end; 




end
