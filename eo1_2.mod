set R; # set of rows
set C; # set of columns
set B; # set of beams

param d_c;  
param d_t;
param t {i in R, j in C};
param c {i in R, j in C};
param b {i in R, j in C, k in B};
param a;
param r;

var x {k in B};
var s_1;
var s_2;

maximize tumor_treatment: 
    (sum {i in R, j in C, k in B} x[k] * b[i, j, k] * t[i, j]) 
    - (sum {i in R, j in C, k in B} x[k] * b[i, j, k] * c[i, j]);

subject to critical_dose {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * c[i, j] <= d_c + s_1;
subject to tumor_dose {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * t[i, j] >= d_t - s_2;
subject to tumor_dose_2 {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * t[i, j] <= r*d_t;
subject to nonneg_x {k in B}: x[k] >= 0;
subject to x_upper {k in B}: x[k] <= 100;
subject to nonneg_s1: s_1 >= 0;
subject to nonneg_s2: s_2 >= 0;

subject to upper_s1: s_1 <= 0.5*d_c;
#subject to upper_s2: s_2 <= 5*d_t;
