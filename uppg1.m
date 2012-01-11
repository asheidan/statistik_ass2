function result = uppg1(N,t,runs)
	result = [];
	for x = 1:runs,
		error_data = sum_errors(N,t);
		stats = sum(error_data < 3) * 100 / N; % Antalet procent under 3 fel
		tmp = find(stats > 95);
		result = [ result tmp(1) ];
	end

function plot_one_try(data)
	lim = ones(1,size(t,2)) * 95;
	m = mean(data);
	v = var(data);
	stats = sum(error_data < 3) * 100 / N; % Antalet procent under 3 fel
	plot_data = [ max(data) ; m ; min(data) ; lim ; stats ];
	save data1.txt plot_data -ascii
	plot(plot_data');
	legend('max','mean','min','95%','% under 3');

function result = sum_errors(N,t)
	if t == 1
		result = random('poiss',70,N,1);
	elseif t > 1
		previous_data = sum_errors(N,t-1);
		[ignore s] = size(previous_data);
		previous = previous_data(:,s);
		fixed = fixed_errors(previous);
		new = new_errors(fixed);
		found = found_errors(N,t);
		result = [previous_data (previous - fixed + new + found)];
	end

function errors = fixed_errors(n)
	errors = random('bino',n,0.5);

function errors = new_errors(n)
	errors = random('bino',n,0.1);

function errors = found_errors(N,t)
	errors = random('poiss',3*(100-t)/100,N,1);