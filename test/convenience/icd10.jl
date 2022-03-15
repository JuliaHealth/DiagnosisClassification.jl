@testset "icd10" begin
    DiagnosisClass  = DiagnosisClassification.DiagnosisClass
    construct_icd10 = DiagnosisClassification.construct_icd10
    construct_ccs10 = DiagnosisClassification.construct_ccs10
    @test construct_icd10("W55.29XA") == DiagnosisClass(
        "diagnosis",
        "ICD10",
        "W55.29XA",
        )
    @test construct_icd10("W5529XA")  == DiagnosisClass(
        "diagnosis",
        "ICD10",
        "W55.29XA",
        )
    @test construct_ccs10("helloworld123")  == DiagnosisClass(
        "diagnosis",
        "CCS10",
        "helloworld123",
    )
end
