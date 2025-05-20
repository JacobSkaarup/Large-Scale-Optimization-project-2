using JuMP, GLPK

function CLSP(model_type)
    # Define parameters
    h = [1 1]
    c = [1  2]
    C = 10
    d = [3 4 5;
        0 5 2]
    q = [2 1]
    M1 = C - minimum(q)
    M2 = M1 
    M3 = 0
    for i in axes(d, 1)
        M3 = max(M3, sum(d[i, :]))
    end

    n, m = size(d) # Number of products

    # Create a model
    model = Model(GLPK.Optimizer)

    # Define variables
    if model_type == "ip" 
        @variable(model, y[1:n, 1:m], Bin) # Product i is produced in time t 
        @variable(model, 0 <= x[1:n, 1:m] <= M2, Int) # Number of product i produced in time t
        @variable(model, 0 <= s[1:n, 1:m] <= M3, Int) # Number of product i stored at end of time t
    elseif model_type == "lp"
        @variable(model, 0 <= y[1:n, 1:m] <= 1) # Product i is produced in time t 
        @variable(model, 0 <= x[1:n, 1:m] <= M2) # Number of product i produced in time t
        @variable(model, 0 <= s[1:n, 1:m] <= M3) # Number of product i stored at end of time t
    end

    # Define objective function
    @objective(model, Min, sum(c[i] * y[i,t] + h[i] * s[i,t] for i in 1:n, t in 1:m))

    # Define constraints
    @constraint(model, [i=1:n], x[i,1] == d[i,1] + s[i,1]) # Initial stock balance
    @constraint(model, [i=1:n, t=2:m], s[i,t-1] + x[i,t] == d[i,t] + s[i,t]) # Stock balance
    @constraint(model, [i=1:n, t=1:m], x[i,t] <= M1 * y[i,t]) # Production allowed only if y[i,t] = 1
    @constraint(model, [t=1:m], sum(x[i,t] + q[i] * y[i,t] for i in 1:n) <= C) # Capacity constraint
    
    # Optimize model
    optimize!(model)

    # Check the optimization status
    if termination_status(model) == MOI.OPTIMAL
        println("Optimal " , model_type , " solution found")
        println("Objective value: ", objective_value(model))
        println("Production plan:")
        for t in 1:m
            println("Time ", t, ":")
            for i in 1:n
                println("Product ", i, ": ", value(x[i,t]), " produced, and ", value(s[i,t]), " stored")
            end
        end
        println()
    else
        println("No optimal solution found")
    end
end


# Get IP solution
CLSP("ip")

# Get LP solution
CLSP("lp")