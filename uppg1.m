function error_data = uppg1(N,t)
	error_data = sum_errors(N,t);
	stats = sum(error_data < 3) * 100 / N;
	lim = ones(1,t) * 95;
	m = mean(error_data);
	v = var(error_data);
	plot_data = [ max(error_data) ; m ; min(error_data) ; lim ; stats ];
	plot(plot_data');
	legend('max','mean','min','95%','% under 3');

function result = sum_errors(N,t)
	if t == 1
		result = random('poiss',70,N,1);
	elseif t > 1
		previous_data = sum_errors(N,t-1);
		[ignore s] = size(previous_data);
		previous = previous_data(:,s);
		fixed = fixed_errors(N,previous);
		new = new_errors(N,fixed);
		found = found_errors(N,t);
		result = [previous_data (previous - fixed + new + found)];
	end

function errors = fixed_errors(N,n)
	errors = random('bino',n,0.5,N,1);

function errors = new_errors(N,n)
	errors = random('bino',n,0.1,N,1);

function errors = found_errors(N,t)
	errors = random('poiss',3*(100-t)/100,N,1);