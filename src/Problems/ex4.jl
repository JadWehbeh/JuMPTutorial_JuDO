function build_ex4(optimizer_type::Type{O}) where {O<:MathOptInterface.AbstractOptimizer}
# Constrained nonlinear example
    model =  Model(optimizer_type)
    @variable(model, x >= 0)
    @variable(model, 1 <= y <= 5)
    @NLobjective(model, Min, exp(x^2+y^2) + 5*(atan(x-3)*y^2)^2)
    @NLconstraint(model, c1, x^2 + 3*y^2 >= 10)
    return model
end