set R;
set C;
set B;

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

maximize tumor_treatment: sum {k in B} x[k] * sum {i in R}
    sum {j in C} b[i, j, k]*(a * t[i,j] - (1 - a) * c[i, j]);

subject to critical_dose {i in R, j in C}: -s_1 + sum {k in B} x[k] * b[i, j, k] * c[i, j] <= d_c;
subject to tumor_dose {i in R, j in C}: s_2 + sum {k in B} x[k] * b[i, j, k] * t[i, j] >= d_t;
subject to tumor_dose_2 {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * t[i, j] <= r*d_t;
subject to nonneg_x {k in B}: x[k] >= 0;
subject to nonneg_s1: s_1 >= 0;
subject to nonneg_s2: s_2 >= 0;
subject to upper_s1: s_1 <= 0.1*d_c;
subject to upper_s2: s_2 >= 0.1*d_t;
