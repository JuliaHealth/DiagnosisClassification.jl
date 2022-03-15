@testset "icd9" begin
    DiagnosisClass = DiagnosisClassification.DiagnosisClass
    construct_icd9 = DiagnosisClassification.construct_icd9
    @test construct_icd9("V01.71") == DiagnosisClass("ICD9", "V01.71")
    @test construct_icd9("V0171")  == DiagnosisClass("ICD9", "V01.71")
end
