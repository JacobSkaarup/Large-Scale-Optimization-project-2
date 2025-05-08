include("q4_setup.jl")

b_sub[2] = vcat(b_sub[2], 1)
A_V[2] = vcat(A_V[2], zeros(1, length(V[2])))
A_V[2][7, 6] = 1
