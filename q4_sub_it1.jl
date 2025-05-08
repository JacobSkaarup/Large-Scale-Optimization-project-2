using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; 0.0; 0.0;;]
kappa = [8.0, 4.0]

solveSubs(piVal, kappa)