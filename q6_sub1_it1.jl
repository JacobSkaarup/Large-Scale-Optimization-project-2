include("q6_setup1.jl")

# dual variables from master problem:
# it 1:
piVal = [0.0; 0.0; 0.0;;]
kappa = [8.0, 4.0]

for k=1:K
    sub = Model(GLPK.Optimizer)

    @variable(sub, y[1:Int(length(V[k])/3)], Bin ) # Binary variables for setup
    @variable(sub, 0 <= x[1:Int(length(V[k])/3)] <= M2, Int ) # Integer variables for production
    @variable(sub, 0 <= s[1:Int(length(V[k])/3)] <= M3, Int ) # Integer variables for storage
    sub_variables = [x; y; s]

    @objective(sub, Min, dot(CV[k], sub_variables) - dot(piVal' * A0_V[k], sub_variables) - kappa[k])
    @constraint(sub, [con=1:3], dot(A_V[k][con,:], sub_variables) == b_sub[k][con] )
    @constraint(sub, [con=4:6], dot(A_V[k][con,:], sub_variables) <= b_sub[k][con] )
    @constraint(sub, [con=7], dot(A_V[k][con,:], sub_variables) <= b_sub[k][con] )

    optimize!(sub)

    if termination_status(sub) == MOI.OPTIMAL
        println("--- Result from sub-problem $k: ---")
        println("Objective value: ", JuMP.objective_value(sub))
        println("x: ", JuMP.value.(sub_variables))
    else
        println("Optimize was not succesful. Return code: ", termination_status(sub))

    end
end