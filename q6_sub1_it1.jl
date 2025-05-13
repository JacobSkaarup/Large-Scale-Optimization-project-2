using JuMP, GLPK, LinearAlgebra
include("q6_setup1.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; 0.0; 0.0;;]
kappa = [6.0, 4.0]

solveSubs(piVal, kappa)