set R;
set C;
set B;

param d_c; 
param d_t;
param t {i in R, j in C};
param c {i in R, j in C};
param b {k in B, i in R, j in C};
param max_strength;

var x {k in B};

maximize tumor_treatment: sum {k in B} x[k] * sum {i in R}
    sum {j in C} b[k, i, j] * (t[i,j] - c[i, j]);

subject to critical_dose {i in R, j in C}: sum {k in B} x[k] * b[k, i, j] * c[i, j] <= d_c;
subject to tumor_dose {i in R, j in C}: sum {k in B} x[k] * b[k, i, j] * t[i, j] >= d_t;
subject to nonneg_x {k in B}: x[k] >= 0;
