function _icd9_force_add_dots(icd9::AbstractString)
    # Regular codes and V codes
    r1 = r"^([\dV]\d\d)$"
    m1 = match(r1, icd9)
    if m1 !== nothing
        return "$(m1[1])"
    end
    r2 = r"^([\dV]\d\d)(\d\d?\d?)$"
    m2 = match(r2, icd9)
    if m2 !== nothing
        return "$(m2[1]).$(m2[2])"
    end

    # E codes
    r3 = r"^(E\d\d\d)$"
    m3 = match(r3, icd9)
    if m3 !== nothing
        return "$(m3[1])"
    end
    r4 = r"^(E\d\d\d)(\d)$"
    m4 = match(r4, icd9)
    if m4 !== nothing
        return "$(m4[1]).$(m4[2])"
    end

    msg = "Invalid ICD-9-CM code: $(icd9)"
    throw(ErrorException(msg))
end

function _icd9_force_remove_dots(icd9::AbstractString)
    # Regular codes and V codes
    r1 = r"^([\dV]\d\d)$"
    m1 = match(r1, icd9)
    if m1 !== nothing
        return "$(m1[1])"
    end
    r2 = r"^([\dV]\d\d)\.(\d\d?)$"
    m2 = match(r2, icd9)
    if m2 !== nothing
        return "$(m2[1])$(m2[2])"
    end

    # E codes
    r3 = r"^(E\d\d\d)$"
    m3 = match(r3, icd9)
    if m3 !== nothing
        return "$(m3[1])"
    end
    r4 = r"^(E\d\d\d)\.(\d)$"
    m4 = match(r4, icd9)
    if m4 !== nothing
        return "$(m4[1])$(m4[2])"
    end

    msg = "Invalid ICD-9-CM code: $(icd9)"
    throw(ErrorException(msg))
end
