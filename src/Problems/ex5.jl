function build_ex5(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
# Simple non-convex example
    model =  Model(optimizer_type)
    @variable(model, -10 <= x <= 10)
    @NLobjective(model, Min, 2*cos(x) - x/2)
    return model
end