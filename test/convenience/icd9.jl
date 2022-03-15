@testset "icd9" begin
    DiagnosisClass = DiagnosisClassification.DiagnosisClass
    construct_icd9 = DiagnosisClassification.construct_icd9
    construct_ccs9 = DiagnosisClassification.construct_ccs9
    @test construct_icd9("V01.71") == DiagnosisClass(
        "diagnosis",
        "ICD9",
        "V01.71",
    )
    @test construct_icd9("V0171")  == DiagnosisClass(
        "diagnosis",
        "ICD9",
        "V01.71",
    )
    @test construct_ccs9("123")  == DiagnosisClass(
        "diagnosis",
        "CCS9",
        "123",
    )
end
