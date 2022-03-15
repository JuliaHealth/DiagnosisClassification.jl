function construct_icd10(icd10::AbstractString)
    domain = "diagnosis"
    system = "ICD10"
    value = icd10_add_dots(icd10)
    return DiagnosisClass(domain, system, value)
end


function construct_ccs10(ccs10::AbstractString)
    domain = "diagnosis"
    system = "CCS10"
    value = ccs10
    return DiagnosisClass(domain, system, value)
end
