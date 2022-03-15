function setindex_no_overwrite!(
        dict::AbstractDict{<:K, <:V},
        key::K,
        new_value,
    ) where {K, V}
    if !haskey(dict, key)
        dict[key] = new_value
        return nothing
    end

    old_value = dict[key]
    msg = "Duplicate key found"
    @error msg key old_value new_value
    throw(ErrorException(msg))
end

function setindex_same_value!(
        dict::AbstractDict{<:K, <:V},
        key::K,
        new_value,
    ) where {K, V}
    if !haskey(dict, key)
        dict[key] = new_value
        return nothing
    end

    old_value = dict[key]
    if old_value !== new_value # we require egality
        msg = "Duplicate key found"
        @error msg key old_value new_value
        throw(ErrorException(msg))
    end

    return nothing
end
