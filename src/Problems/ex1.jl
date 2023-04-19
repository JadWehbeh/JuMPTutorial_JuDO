function build_ex1(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
# Single variable quadratic example
    model =  Model(optimizer_type)
    @variable(model,x)
    @objective(model, Min, 2*(x-3)^2 + 5)
    return model
end