using JuMP, GLPK, LinearAlgebra
include("q6_setup2.jl")

include("solveSubs.jl")

# dual variables from master problem:
piVal = [0.0; -0.5; -0.75;;]
kappa = [11.25, 10.75]

solveSubs(piVal, kappa)