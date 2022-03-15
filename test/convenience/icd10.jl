@testset "icd10" begin
    DiagnosisClass  = DiagnosisClassification.DiagnosisClass
    construct_icd10 = DiagnosisClassification.construct_icd10
    @test construct_icd10("W55.29XA") == DiagnosisClass("ICD10", "W55.29XA")
    @test construct_icd10("W5529XA")  == DiagnosisClass("ICD10", "W55.29XA")
end
