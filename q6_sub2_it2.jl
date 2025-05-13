using JuMP, GLPK, LinearAlgebra
include("q6_setup2.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -1.0; 0.0;;]
kappa = [9.0, 10.0]

solveSubs(piVal, kappa)