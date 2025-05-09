function solveMaster(X)
    P = [size(X[1])[2], size(X[2])[2]]

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

    println("Converted solutions")
    println(round.(X[1] * value.(lambda[1]), sigdigits=2))
    println(round.(X[2] * value.(lambda[2]), sigdigits=2))
end