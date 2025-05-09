include("q4_data.jl")

# Rows in the master problem
masterRows = [13, 14, 15]

# Rows in subproblems
subBlocks=[[1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12]]

K = length(subBlocks) # Number of subproblems

# Variables in subproblems
V = Vector{Vector{Int64}}(undef, K)
V[1] = [1, 2, 3, 7, 8, 9, 13, 14, 15]
V[2] = [4, 5, 6, 10, 11, 12, 16, 17, 18]

A0 = A[masterRows,:]
b0 = b[masterRows,:]
senses0 = senses[masterRows,:]

CV = Vector{Array{Float64,2}}(undef,K)
A_V = Vector{Array{Float64,2}}(undef,K)
A0_V = Vector{Array{Float64,2}}(undef,K)
b_sub = Vector{Array{Float64,2}}(undef,K)
senses_sub = Vector{Array{String}}(undef,K)
for k=1:K
    CV[k] = C[:,V[k]]
    A_V[k] = A[subBlocks[k],V[k]]
    A0_V[k] = A0[:,V[k]]
    b_sub[k] = b[subBlocks[k],:]
    senses_sub[k] = senses[subBlocks[k],:]
end