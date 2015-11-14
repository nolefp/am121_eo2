# first get param total pairs so we can then create set
param total_pairs;

# set of all pairs (including members i,j : i=j, I deal with this later, I think 
# we actually have to because otherwise we can't read in the matrices for param 
# coampatible, it gave me back this error when I tried "invalid subscript compatible[1,1]"
# *note: these are pairs of pairs of donor-reciever			
set PAIRS = {(1 .. total_pairs) cross (1 .. total_pairs)};


param compatible {(i,j) in PAIRS};

# swap happens or not?
var pair_swap {(i,j) in PAIRS} binary; 


maximize Total_swaps: 
		sum {(i,j) in PAIRS} pair_swap[i,j];

subject to One_Kidney_To_Give {i in (1 .. total_pairs)}:
		sum {(i,j) in PAIRS} pair_swap[i,j] <= 1;

subject to One_Kidney_To_Recieve {j in (1 .. total_pairs)}:
		sum {(i,j) in PAIRS} pair_swap[i,j] <= 1;

subject to Two_Cycles {(i,j) in PAIRS}:
		pair_swap[i,j] = pair_swap[j,i];

subject to Compatible {(i, j) in PAIRS}:
        pair_swap[i,j] <= compatible[i,j]
