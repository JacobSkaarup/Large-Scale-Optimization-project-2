include("q4_setup.jl")

b_sub[1] = vcat(b_sub[1], 1)
A_V[1] = vcat(A_V[1], zeros(1, length(V[1])))
A_V[1][7, 5] = 1
