function solveSubs(piVal, kappa)
    for k=1:K
        sub = Model(GLPK.Optimizer)
    
        @variable(sub, y[1:Int(length(V[k])/3)], Bin ) # Binary variables for setup
        @variable(sub, 0 <= x[1:Int(length(V[k])/3)] <= M2, Int ) # Integer variables for production
        @variable(sub, 0 <= s[1:Int(length(V[k])/3)] <= M3, Int ) # Integer variables for storage
        sub_variables = [x; y; s]
    
        @objective(sub, Min, dot(CV[k], sub_variables) - dot(piVal' * A0_V[k], sub_variables) - kappa[k])
        for con in axes(A_V[k],1)
            if senses_sub[k][con] == "eq"
                @constraint(sub, dot(A_V[k][con,:], sub_variables) == b_sub[k][con] )
            elseif senses_sub[k][con] == "leq"
                @constraint(sub, dot(A_V[k][con,:], sub_variables) <= b_sub[k][con] )
            else
                @constraint(sub, dot(A_V[k][con,:], sub_variables) >= b_sub[k][con] )
            end
        end
        
        optimize!(sub)
    
        if termination_status(sub) == MOI.OPTIMAL
            println("--- Result from sub-problem $k: ---")
            println("Objective value: ", JuMP.objective_value(sub))
            println("x: ", round.(JuMP.value.(sub_variables), sigdigits=3))
        else
            println("Optimize was not succesful. Return code: ", termination_status(sub))
        end
    end
end