@testset "icd9" begin
    DiagnosisClass = DiagnosisClassification.DiagnosisClass
    construct_icd9 = DiagnosisClassification.construct_icd9
    construct_ccs9 = DiagnosisClassification.construct_ccs9
    @test construct_icd9("V01.71") == DiagnosisClass(;
        system = "ICD9",
        value = "V01.71",
    )
    @test construct_icd9("V0171")  == DiagnosisClass(;
        system = "ICD9",
        value = "V01.71",
    )
    @test construct_ccs9("123")  == DiagnosisClass(;
        system = "CCS9",
        value = "123",
    )
end
