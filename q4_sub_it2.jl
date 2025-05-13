using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.83333; 0.0;;]
kappa = [8.0, 10.667]

solveSubs(piVal, kappa)