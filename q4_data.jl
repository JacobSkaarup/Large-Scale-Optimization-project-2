h = [1 1] # Holding cost
costs = [1 2] # Setup cost
Capacity = 10 # Capacity
q = [2 1] # Setup capacity need - equivalent
d = [3 4 5; 0 5 2] # Demand matrix (for product i at time j - indexed by [i,j])

n, m = size(d) # Number of products and time periods

M1 = Capacity - minimum(q)
M2 = Capacity - minimum(q)
M3 = maximum(sum(d[nn,mm] for mm in 2:m) for nn in 1:n) # Maximum demand for product i at time j

senses = ["eq"; "eq"; "eq"; "leq"; "leq"; "leq";
          "eq"; "eq"; "eq"; "leq"; "leq"; "leq";
          "eq"; "eq"; "eq";]

C = [0 0 0 0 0 0 costs[1] costs[1] costs[1] costs[2] costs[2] costs[2] h[1] h[1] h[1] h[2] h[2] h[2]] # Cost vector
b = [d[1,1]; d[1,2]; d[1,3]; 0; 0; 0; d[2,1]; d[2,2]; d[2,3]; 0; 0; 0; Capacity; Capacity; Capacity] # Right-hand side vector
n_vars = length(C) # Number of variables
n_constraints = length(b) # Number of constraints
A = zeros(n_constraints, n_vars) # Coefficient matrix
A[1,1] = 1 # Product 1 at time 1
A[2,2] = 1 # Product 1 at time 2
A[3,3] = 1 # Product 1 at time 3
A[4,1] = 1
A[5,2] = 1
A[6,3] = 1
A[7,4] = 1 # Product 2 at time 1
A[8,5] = 1 # Product 2 at time 2
A[9,6] = 1 # Product 2 at time 3
A[10,4] = 1
A[11,5] = 1
A[12,6] = 1
A[13,1] = 1 # Product 1 at time 1
A[13,4] = 1 # Product 1 at time 1
A[14,2] = 1 # Product 1 at time 2
A[14,5] = 1 # Product 1 at time 2
A[15,3] = 1 # Product 1 at time 3
A[15,6] = 1 # Product 1 at time 3
A[4,7] = - M1
A[5,8] = - M1
A[6,9] = - M1
A[10,10] = - M1
A[11,11] = - M1
A[12,12] = - M1
A[13,7] = q[1]
A[13,10] = q[2]
A[14,8] = q[1]
A[14,11] = q[2]
A[15,9] = q[1]
A[15,12] = q[2]
A[1,13] = -1
A[2,14] = -1
A[3,15] = -1
A[2,13] = 1
A[3,14] = 1
A[7,16] = -1
A[8,17] = -1
A[9,18] = -1
A[8,16] = 1
A[9,17] = 1
