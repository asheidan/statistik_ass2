function uppg2(in)
	A = importdata('Data1lab2.txt','\t');
	difference = A.data(:,1)-A.data(:,2);
	hist(difference)