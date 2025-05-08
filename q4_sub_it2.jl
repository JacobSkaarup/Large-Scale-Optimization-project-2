using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.8333333333333334; 0.0;;]
kappa = [8.0, 10.666666666666668]

solveSubs(piVal, kappa)