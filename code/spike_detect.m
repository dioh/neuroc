function m = spike_detect(data, sr, st_i, en_i, use_3sv)
% Detects and alligns spikes following the following idea:
%% Taking the signal by 2ms window, remove the values below threshold
%% Look for local max val
%% Using the max as a center add the data-window to the resultset.
%% Parameters:
%% Unidimentional vector, sample rate, start index, end index.
%% If end index - start index is not a window size multiple, raises an invalid window exception.



m = []; 

d_v = data(st_i:en_i);
me = mean(d_v);
st = std(d_v);

th = me +  3*st ;
if(not(use_3sv))
	%% What is 0.6745 ?? Maguc number!
	crazy_crazy_qq = 0.6745;
	th = me +  median(data / crazy_crazy_qq );
	th
end;

% Window size is divided in two, 1ms for the start potential, 1.5 ms for the remining after the peak.
spk_dur = 2.5;
b_peak = 1 * sr / 1000; 
a_peak = 1.5 * sr / 1000; 
%b_peak = 10;
%a_peak = 22
wsize =  b_peak + a_peak;

assert(mod(1 + en_i - st_i, wsize) == 0, 'Invalid window size, check for a valid window.');


%% Filtro por threshold
val_uth = find( d_v >= th) ;

%% Busco maximo por intervalo de a wsize mediciones (2ms por spike a 24khz son 48 observaciones) 
%for i=1:2;
% FIXME: estoy generando wsize + 1 valores
% No estoy recorriendo los primeros 60 valores.

for i=1:(length(d_v ) - wsize) / wsize;
	s_i = (i-1) * wsize + 1; % Window start index
	e_i = (i * wsize  ); % Window end index
	c_win = d_v(s_i : e_i); 
	[e, i] = max(c_win); % This is the pivot of the window, the centroid of the spike.
	%e
	%th
	%%find(c_win >= th)
	%c_win(find(c_win >= th))
	if (e < th) 
		%'continue'
		continue;
	%else
	%	'adding'

	end;
	

	abs_i = i + s_i; % Max value absolute position
	abs_st_i = max(abs_i - b_peak, 1);
	abs_e_i = min(abs_i + a_peak, length(d_v)) - 1;

	%assert(mod(1 + abs_e_i - abs_st_i, wsize) == 0, 'data window misplaced between %d and %d indexes. wsize == %d', abs_st_i, abs_e_i, wsize);
	if(mod(1 + abs_e_i - abs_st_i, wsize) ~= 0)
		continue;
	end;

	m(end + 1,:) = d_v(abs_st_i: abs_e_i); 
end; 




end
