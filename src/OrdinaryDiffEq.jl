module OrdinaryDiffEq

  using DiffEqBase
  import DiffEqBase: solve
  using Parameters, GenericSVD, ForwardDiff, InplaceOps, RecursiveArrayTools,
        Ranges, NLsolve, RecipesBase, Juno

  import Base: linspace
  import ForwardDiff.Dual

  macro def(name, definition)
      return quote
          macro $name()
              esc($(Expr(:quote, definition)))
          end
      end
  end

  typealias KW Dict{Symbol,Any}
  AbstractArrayOrVoid = Union{AbstractArray,Void}
  NumberOrVoid = Union{Number,Void}
  FunctionOrVoid = Union{Function,Void}

  #Constants

  const TEST_FLOPS_CUTOFF = 1e10
  const initialized_backends = Set{Symbol}()

  include("backends.jl")
  include("misc_utils.jl")
  include("alg_utils.jl")
  include("integrators/integrator_utils.jl")
  include("integrators/fixed_timestep_integrators.jl")
  include("integrators/explicit_rk_integrator.jl")
  include("integrators/low_order_rk_integrators.jl")
  include("integrators/high_order_rk_integrators.jl")
  include("integrators/verner_rk_integrators.jl")
  include("integrators/feagin_rk_integrators.jl")
  include("integrators/implicit_integrators.jl")
  include("integrators/rosenbrock_integrators.jl")
  include("integrators/threaded_rk_integrators.jl")
  include("constants.jl")
  include("callbacks.jl")
  include("solve.jl")
  include("dense.jl")
  include("odeinterface_solve.jl")
  include("odepr49.jl")
  include("integrators/unrolled_tableaus.jl")


  #General Functions
  export solve

  #Callback Necessary
  export ode_addsteps!, ode_interpolant, DIFFERENTIALEQUATIONSJL_SPECIALDENSEALGS,
        @ode_callback, @ode_event, @ode_change_cachesize, @ode_change_deleteat,
        @ode_terminate, @ode_savevalues, copyat_or_push!, isspecialdense

  export constructDP5, constructVern6, constructDP8, constructDormandPrince, constructFeagin10,
        constructFeagin12, constructFeagin14

  # Reexport the Alg Types

  export OrdinaryDiffEqAlgorithm, OrdinaryDiffEqAdaptiveAlgorithm,
        Euler, Midpoint, RK4, ExplicitRK, BS3, BS5, DP5, DP5Threaded, Tsit5,
        DP8, Vern6, Vern7, Vern8, TanYam7, TsitPap8, Vern9, ImplicitEuler,
        Trapezoid, Rosenbrock23, Rosenbrock32, Feagin10, Feagin12, Feagin14
end # module