# module CLSP_master
# This is the master problem for the CLSP problem

using JuMP, GLPK, LinearAlgebra

include("q4_setup.jl")

# X[k] Extreme points for polyhedron k
X = Vector{Array{Int64,2}}(undef,K)
X[1] = [8 0 4 1 0 1 5 1 0]' # Provide initial extreme points for polyhedron 1
X[2] = [0 7 0 0 1 0 0 2 0]' # Provide initial extreme points for polyhedron 2

# P[k] number of extreme points for polyhedron k
P = [1, 1]

master = Model(GLPK.Optimizer)

# Create a vector that contain vectors of decision variables
@variable(master, lambda1[1:P[1]] >= 0 )
@variable(master, lambda2[1:P[2]] >= 0 ) 
lambda = [lambda1, lambda2]

@objective(master, Min, sum(dot(CV[k]*X[k], lambda[k]) for k=1:K))
@constraint(master, cons, sum(A0_V[k]*X[k]*lambda[k] for k=1:K ) .<= b0 )
@constraint(master, convexityCons[k=1:K], sum(lambda[k][j] for j=1:P[k]) >= 1)

optimize!(master)

if termination_status(master) == MOI.OPTIMAL
    println("Objective value: ", JuMP.objective_value(master))
    lambdaVal = [JuMP.value.(lambda[k]) for k=1:K]
    println("lambda: ", lambdaVal)
    println("piVal = ", dual.(cons))
    println("kappa = ", dual.(convexityCons))
else
    println("Optimize was not succesful. Return code: ", termination_status(master))
end

# end