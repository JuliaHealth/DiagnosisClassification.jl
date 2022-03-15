function construct_icd10(icd10::AbstractString)
    system = "ICD10"
    value = icd10_add_dots(icd10)
    return DiagnosisClass(system, value)
end
