param upper; # Maximum allowed radiation for critical pixels
param lower; # Minimum allowed radiation for tumorous pixels
param beam_no; # Number of beams
param row_no; # Horizontal resolution
param col_no; # Vertical resolution
param small_int; # Smallest nonzero intensity by any beam in any pixel
param nc_upper; # Maximum allowed radiation for non-critical pixels

set R := 1 .. row_no; # Set of rows
set C := 1 .. col_no; # Set of columns
set B := 1 .. beam_no; # Set of beams

param I {b in B, r in R, c in C}; # Intensity of b in (r,c)
param T {r in R, c in C}; # Indicator for tumor in (r,c)
param A {r in R, c in C}; # Indicator for critical in (r,c)

var x {b in B}; # Intensity of b
var y {r in R, c in C}; # Deviation from upper bound
var z {r in R, c in C}; # Deviation from lower bound

maximize Effectiveness: 
(sum {r in R, c in C, b in B} (x[b] * I[b,r,c] * T[r,c])) 
- (sum {r in R, c in C, b in B} (x[b] * I[b,r,c] * A[r,c])) 
- (1/small_int) * (max {b in B} (sum {r in R, c in C} I[b,r,c])) * (sum {r in R, c in C} y[r,c] + sum {r in R, c in C} z[r,c]); 

# difference between amount delivered to tumor and amount delivered to critical region with penalty to deviation


subject to Max_Int {r in R, c in C}: sum {b in B} (I[b,r,c] * x[b] * A[r,c]) - y[r,c] <= upper; # Radiation for critical pixels must be less than limit, accounting for deviation

subject to Min_Int {r in R, c in C}: sum {b in B} (I[b,r,c] * x[b]) + z[r,c] >= lower * T[r,c]; # Radiation for tumorous pixels must be more than limit, accounting for deviation

subject to Non_crit {r in R, c in C}: sum {b in B} (I[b,r,c] * x[b] * (1 - A[r,c]) * (1 - T[r,c])) <= nc_upper; # Radiation for non-critical pixels must be less than limit

subject to nonnegativity1 {b in B}: x[b] >= 0; # Beam intensity should be nonnegative
subject to nonnegativity2 {r in R, c in C}: y[r,c] >= 0; # Deviation should be nonnegative
subject to nonnegativity3 {r in R, c in C}: z[r,c] >= 0; # Deviation should be nonnegative
