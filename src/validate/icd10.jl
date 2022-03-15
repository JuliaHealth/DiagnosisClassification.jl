function _icd10_force_add_dots(icd10::AbstractString)
    r1 = r"^([A-Z]\d\d)$"
    m1 = match(r1, icd10)
    if m1 !== nothing
        return "$(m1[1])"
    end

    r2 = r"^([A-Z]\d\d)([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m2 = match(r2, icd10)
    if m2 !== nothing
        return "$(m2[1]).$(m2[2])"
    end

    msg = "Invalid ICD-10-CM code: $(icd10)"
    throw(ErrorException(msg))
end

function _icd10_force_remove_dots(icd10::AbstractString)
    r1 = r"^([A-Z]\d\d)$"
    m1 = match(r1, icd10)
    if m1 !== nothing
        return "$(m1[1])"
    end

    r2 = r"^([A-Z]\d\d)\.([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m2 = match(r2, icd10)
    if m2 !== nothing
        return "$(m2[1])$(m2[2])"
    end

    msg = "Invalid ICD-10-CM code: $(icd10)"
    throw(ErrorException(msg))
end
