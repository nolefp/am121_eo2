set R; # set of rows
set C; # set of columns
set B; # set of beams

param d_c;  
param d_t;
param t {i in R, j in C};
param c {i in R, j in C};
param b {k in B, i in R, j in C};
param a;
param r;

var x {k in B};
var s_1 {i in R, j in C};
var s_2 {i in R, j in C};

maximize tumor_treatment: 
    (sum {k in B, i in R, j in C} x[k] * b[k, i, j]  * t[i, j]) 
    - (sum {k in B, i in R, j in C} x[k] * b[k, i, j] * c[i, j])
    - 10000 * (sum {i in R, j in C} (s_1[i, j] + s_2[i, j]));
    #- 50 *(max {k in B} (sum {i in R, j in C} b[k, i, j])) * 
    #(sum {i in R, j in C} s_1[i, j] + sum {i in R, j in C} s_2[i, j]);

subject to critical_dose {i in R, j in C}: sum {k in B} (x[k] * b[k, i, j]) * c[i, j] <= (d_c + s_1[i, j])*c[i, j];
subject to tumor_dose {i in R, j in C}: sum {k in B} (x[k] * b[k, i, j]) * t[i, j] >= (d_t - s_2[i, j])*t[i, j];
#subject to tumor_dose_2 {i in R, j in C}: sum {k in B} x[k] * b[k, i, j] * t[i, j] <= r*d_t;
subject to nonneg_x {k in B}: x[k] >= 0;
subject to x_upper {k in B}: x[k] <= 105;
subject to nonneg_s1 {i in R, j in C}: s_1[i, j] >= 0;
subject to nonneg_s2 {i in R, j in C}: s_2[i, j] >= 0;
#subject to upper_s1 {i in R, j in C}: s_1[i, j] <= d_c;
