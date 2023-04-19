module JuMPTutorial_JuDO

using JuMP, MathOptInterface, Plots, Reexport
@reexport using JuMP

include("Problems/ex1.jl")
include("Problems/ex2.jl")
include("Problems/ex3.jl")
include("Problems/ex4.jl")
include("Problems/ex5.jl")
include("Problems/ex6.jl")

export build_ex1, build_ex2, build_ex3, build_ex4, build_ex5, build_ex6, plot_ex6_pos, plot_ex6_vel, plot_ex6_ctrl

end
