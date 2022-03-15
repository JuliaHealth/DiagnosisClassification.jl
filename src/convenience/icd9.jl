function construct_icd9(icd9::AbstractString)
    domain = "diagnosis"
    system = "ICD9"
    value = icd9_add_dots(icd9)
    return DiagnosisClass(domain, system, value)
end

function construct_ccs9(ccs9::AbstractString)
    domain = "diagnosis"
    system = "CCS9"
    value = ccs9
    return DiagnosisClass(domain, system, value)
end
