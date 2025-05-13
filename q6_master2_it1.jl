using JuMP, GLPK, LinearAlgebra

include("q6_setup2.jl")

include("solveMaster.jl")

# X[k] Extreme points for polyhedron k
X = Vector{Array{Int64,2}}(undef,K)
X[1] =  hcat([5, 2, 5, 1, 1, 1, 2, 0, 0],) # Provide initial extreme points for polyhedron 1
X[2] =  hcat([0, 5, 2, 0, 1, 1, 0, 0, 0]) # Provide initial extreme points for polyhedron 2

solveMaster(X)