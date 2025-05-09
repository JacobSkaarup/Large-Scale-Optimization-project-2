using JuMP, GLPK, LinearAlgebra

include("q6_setup2.jl")

include("solveMaster.jl")

# X[k] Extreme points for polyhedron k
X = Vector{Array{Int64,2}}(undef,K)
X[1] = [8 0 4 1 0 1 5 1 0]'
X[2] = [0 7 0 0 1 1 0 2 0]'
solveMaster(X)