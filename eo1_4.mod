set R; # set of rows
set C; # set of columns
set B; # set of beams
set L; 

param d_c;  
param d_t;
param t {i in R, j in C};
param c {i in R, j in C};
param b {k in B, i in R, j in C};
param u {k in B, i in R, j in C};
param max_strength;
param g;

var x {k in B};
var s_1 {i in R, j in C};
var s_2 {i in R, j in C};

maximize tumor_treatment: 
    (sum {k in B, i in R, j in C} 10 * (1/12250 * g^2 + 6/1225 * g + 81/98) * x[k] * b[k, i, j]  * t[i, j]) 
    - (sum {k in B, i in R, j in C} x[k] * b[k, i, j] * c[i, j])
    - 100 * (sum {i in R, j in C} (s_1[i, j] + s_2[i, j]))
    - (sum {k in B} x[k] * sum{i in R, j in C} b[k, i, j] * (1 - c[i, j]) 
    * prod {l in L: (i+l) >= 0 and (j+l) >= 0 and (i+l) < card(R) and (j+1) < card(C)} (1 - c[i+l, j+l]))
    - 10 * (sum {k in B, i in R, j in C} x[k] * u[k, i, j]);

subject to critical_dose {i in R, j in C}: sum {k in B} (x[k] * b[k, i, j]) * c[i, j] <= (d_c + s_1[i, j])*c[i, j];
subject to tumor_dose {i in R, j in C}: sum {k in B} (x[k] * b[k, i, j]) * t[i, j] >= (d_t - s_2[i, j])*t[i, j];
subject to nonneg_x {k in B}: x[k] >= 0;
subject to x_upper {k in B}: x[k] <= max_strength;
subject to nonneg_s1 {i in R, j in C}: s_1[i, j] >= 0;
subject to nonneg_s2 {i in R, j in C}: s_2[i, j] >= 0;
