using JuMP, Gurobi

# Define parameters
h = [1 1]
c = [1  2]
C = 10
d = [3 4 5;
     0 5 2]
q = [2 1]

# Create a model
model = Model(Gurobi.Optimizer)
set_optimizer_attribute(model, "outputflag", 0) # Suppress Gurobi output

