include("q4_setup.jl")

b_sub[2] = vcat(b_sub[2], 1) # New constraint fixing binary to 1
A_V[2] = vcat(A_V[2], zeros(1, length(V[2]))) # Add row to constraint matrix for subproblem 2
A_V[2][7, 6] = 1 # The binary is the 6th variable of the 2nd subproblem (3rd time periods y-variable)
senses_sub[2] = vcat(senses_sub[2], "geq") # Add sense to the new constraint