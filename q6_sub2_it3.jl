using JuMP, GLPK, LinearAlgebra
include("q6_setup2.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.83333; 0.0;;]
kappa = [8.0, 9.0]

solveSubs(piVal, kappa)