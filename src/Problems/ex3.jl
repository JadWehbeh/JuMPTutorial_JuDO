function build_ex3(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
 # Constrained quadratic example
    model =  Model(optimizer_type)
    @variable(model, x >= 0)
    @variable(model, 1 <= y <= 5)
    @objective(model, Min, (x-2)^2 + (y+3)^2 + 3)
    @constraint(model, c1, -x + y >= 0)
    return model
end