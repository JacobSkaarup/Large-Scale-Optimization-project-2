using JuMP, GLPK, LinearAlgebra
include("q6_setup2.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.69231; -0.84615;;]
kappa = [13.077, 12.385]

solveSubs(piVal, kappa)