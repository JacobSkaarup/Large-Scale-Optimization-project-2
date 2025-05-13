include("q4_setup.jl")

b_sub[1] = vcat(b_sub[1], 0) # New constraint fixing binary to 0
A_V[1] = vcat(A_V[1], zeros(1, length(V[1]))) # Add row to constraint matrix for subproblem 2
A_V[1][7, 5] = 1 # The binary is the 6th variable of the 2nd subproblem (3rd time periods y-variable)
senses_sub[1] = vcat(senses_sub[1], "leq") # Add sense to the new constraint

