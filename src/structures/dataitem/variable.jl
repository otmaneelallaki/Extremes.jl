
struct Variable <: DataItem
    name :: String
    value :: Vector{<:Real}
end

function standardize(v::Variable)::VariableStd

    x = v.value

    x̄ = mean(x)
    s = std(x)

    offset = isapprox(x̄,0) ? zero(typeof(x[1])) : x̄
    scale = isapprox(s,1) ? one(typeof(x[1])) : s

    z = (x .- offset) ./ scale

    vstd = VariableStd(v.name, z, offset, scale)

    return vstd

end
