using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.5; -0.33333;;]
kappa = [8.3333, 8.0]

solveSubs(piVal, kappa)