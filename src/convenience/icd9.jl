function construct_icd9(icd9::AbstractString)
    system = "ICD9"
    value = icd9_add_dots(icd9)
    return DiagnosisClass(system, value)
end
