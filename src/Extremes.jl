module Extremes

using Distributions, DataFrames, Dates
using Optim, NLSolversBase, ForwardDiff
using SpecialFunctions, LinearAlgebra, Statistics
using Mamba, ProgressMeter

import CSV
import Distributions.quantile
import Statistics.var


abstract type EVA end

struct BlockMaxima <: EVA
    distribution::Type
    data::Dict
    dataid::Symbol
    covariate::Dict
    locationfun::Function
    logscalefun::Function
    shapefun::Function
    nparameter::Int
    paramindex::Dict
end

struct PeaksOverThreshold <: EVA
    distribution::Type
    data::Dict
    dataid::Symbol
    nobsperblock::Int
    covariate::Dict
    threshold::Vector{<:Real}
    logscalefun::Function
    shapefun::Function
    nparameter::Int
    paramindex::Dict
end

struct pwmEVA
    "Extreme value model definition"
    model::EVA
    "Maximum likelihood estimate"
    θ̂::Vector{Float64}
end

struct MaximumLikelihoodEVA
    "Extreme value model definition"
    model::EVA
    "Maximum likelihood estimate"
    θ̂::Vector{Float64}
    "Hessian matrix"
    H::Array{Float64}
end

struct BayesianEVA
    "Extreme value model definition"
    model::EVA
    "MCMC outputs"
    sim::Mamba.Chains
end

Base.Broadcast.broadcastable(obj::Extremes.EVA) = Ref(obj)

include("functions.jl")
include("mle_functions.jl")
include("bayes_functions.jl")
include("utils.jl")
include("data_functions.jl")
include("pwm_functions.jl")

export getcluster, gevfit, gevfitbayes, load

end # module
