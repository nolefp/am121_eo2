set R;
set C;
set B;

param d_c; 
param d_t;
param t {i in R, j in C};
param c {i in R, j in C};
param b {i in R, j in C, k in B};
param a;

var x {k in B};

maximize tumor_treatment: sum {k in B} x[k] * sum {i in R}
    sum {j in C} b[i, j, k] * (a * t[i,j] - (1 - a) * c[i, j]);

subject to critical_dose {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * c[i, j] <= d_c;
subject to tumor_dose {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * t[i, j] >= d_t;
subject to tumor_dose_2 {i in R, j in C}: sum {k in B} x[k] * b[i, j, k] * t[i, j] >= 1.5 * d_t;
subject to non_neg_x {k in B}: x[k] >= 0;
