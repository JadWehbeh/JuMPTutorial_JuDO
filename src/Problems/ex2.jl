function build_ex2(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
    model =  Model(optimizer_type)
    @variable(model, x)
    @variable(model, y)
    @objective(model, Min, (x-2)^2 + (y+3)^2 + 3)
    return model
end