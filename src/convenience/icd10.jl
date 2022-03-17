function construct_icd10(icd10::AbstractString)
    system = "ICD10"
    value = icd10_add_dots(icd10)
    return DiagnosisClass(; system, value)
end


function construct_ccs10(ccs10::AbstractString)
    system = "CCS10"
    value = ccs10
    return DiagnosisClass(; system, value)
end
