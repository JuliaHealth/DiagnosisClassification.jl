function icd10_add_dots(icd10::AbstractString)
    ### Input is too short for a dot
    r1 = r"^([A-Z][A-Z\d][A-Z\d])$"
    m1 = match(r1, icd10)
    if m1 !== nothing
        return "$(m1[1])"::String
    end

    ### Input contains a dot
    r2 = r"^([A-Z][A-Z\d][A-Z\d])\.([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m2 = match(r2, icd10)
    if m2 !== nothing
        return "$(m2[1]).$(m2[2])"::String
    end

    ### Input does not contain a dot
    r3 = r"^([A-Z][A-Z\d][A-Z\d])([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m3 = match(r3, icd10)
    if m3 !== nothing
        return "$(m3[1]).$(m3[2])"::String
    end

    msg = "Invalid ICD-10-CM code: $(icd10)"
    throw(ErrorException(msg))
end

function icd10_remove_dots(icd10::AbstractString)
    ### Input is too short for a dot
    r1 = r"^([A-Z][A-Z\d][A-Z\d])$"
    m1 = match(r1, icd10)
    if m1 !== nothing
        return "$(m1[1])"::String
    end

    ### Input contains a dot
    r2 = r"^([A-Z][A-Z\d][A-Z\d])\.([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m2 = match(r2, icd10)
    if m2 !== nothing
        return "$(m2[1])$(m2[2])"::String
    end

    ### Input does not contain a dot
    r3 = r"^([A-Z][A-Z\d][A-Z\d])([A-Z\d][A-Z\d]?[A-Z\d]?[A-Z\d]?)$"
    m3 = match(r3, icd10)
    if m3 !== nothing
        return "$(m3[1])$(m3[2])"::String
    end

    msg = "Invalid ICD-10-CM code: $(icd10)"
    throw(ErrorException(msg))
end
