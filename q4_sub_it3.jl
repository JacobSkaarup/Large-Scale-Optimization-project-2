using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.5; -0.2;;]
kappa = [7.4, 8.0]

solveSubs(piVal, kappa)