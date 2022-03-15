function setindex_no_overwrite!(
        dict::AbstractDict{<:K, <:V},
        key::K,
        new_value,
    ) where {K, V}
    if haskey(dict, key)
        old_value = dict[key]
        msg = "Duplicate key found"
        @error msg key old_value new_value
        throw(ErrorException(msg))
    end
    dict[key] = new_value
    return nothing
end
