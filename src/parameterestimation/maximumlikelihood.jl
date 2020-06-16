"""
    fit(model::EVA)

Fit the extreme value model by maximum likelihood.

"""
function fit(model::EVA)::MaximumLikelihoodEVA

    initialvalues = getinitialvalue(model)

    fobj(θ) = -loglike(model, θ)

    res = optimize(fobj, initialvalues)

    if Optim.converged(res)
        θ̂ = Optim.minimizer(res)
    else
        @warn "The maximum likelihood algorithm did not find a solution. Maybe try with different initial values or with another method. The returned values are the initial values."
        θ̂ = initialvalues
    end

    fittedmodel = MaximumLikelihoodEVA(model, θ̂)

    return fittedmodel

end

include(joinpath("maximumlikelihood", "maximumlikelihood_gev.jl"))
include(joinpath("maximumlikelihood", "maximumlikelihood_gp.jl"))
