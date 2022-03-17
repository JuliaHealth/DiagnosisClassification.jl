@testset "types" begin
    Class          = DiagnosisClassification.Class
    DiagnosisClass = DiagnosisClassification.DiagnosisClass
    @testset begin
        domain = "diagnosis"
        system = "hello"
        value  = "world"
        @test DiagnosisClass(; system, value) == Class(; domain, system, value)
    end
end
