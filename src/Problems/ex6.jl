function build_ex6(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
# Function to build example optimal control problem for a system with position kinematics dot{x} = v and velocity dynamics dot{v} = u
# Goal is to reach final position 10 starting from 0 in minimum time while subject to velocity and control input constraints
# The transcrption uses a uniform mesh, piecewise constant inputs, and enforces the dynamics through collocation at the mesh nodes using a midpoint rule

    n = 200 # time steps

    model =  Model(optimizer_type)

    @variables(model, begin
        t_0 == 0                    # initial time
        t_f >= 0                    # final time
        0 <= x[1:n] <= 10           # position
        0 <= v[1:n] <= 1            # velocity
        -0.3 <= u[1:(n-1)] <= 0.5   # Control input, acceleration
    end);
    
    # Minimum time objective
    @objective(model, Min, t_f)
    
    # Initial conditions
    @constraint(model, x[1] == 0)
    @constraint(model, v[1] == 0)

    # Dynamics enforced through collocation
    for i in 1:(n-1)
        # Position dynamics
        @NLconstraint(model, (x[i+1] - x[i])*(n/(t_f-t_0)) - (v[i] + v[i+1])/2 == 0)
        # Velocity dynamics
        @NLconstraint(model, (v[i+1] - v[i])*(n/(t_f-t_0)) - u[i] == 0)
    end

    # Terminal constraints
    @constraint(model, x[n] == 10)
    @constraint(model, v[n] == 0)

    return model
end

function plot_ex6_pos(model::JuMP.Model)
# Plot position over time
    n = 200
    p = plot(LinRange(value(model[:t_0]),value(model[:t_f]),n), value.(model[:x]))
    xlabel!("t")
    ylabel!("x")
    display(p)
    return
end

function plot_ex6_vel(model::JuMP.Model)
# Plot velocity over time
    n = 200
    p =plot(LinRange(value(model[:t_0]),value(model[:t_f]),n), value.(model[:v]))
    xlabel!("t")
    ylabel!("v")
    display(p)
end

function plot_ex6_ctrl(model::JuMP.Model)
# Plot control input over time
    n = 200
    p = plot(LinRange(value(model[:t_0]),value(model[:t_f])*(n-1)/n,(n-1)), value.(model[:u]))
    xlabel!("t")
    ylabel!("u")
    display(p)
    return
end