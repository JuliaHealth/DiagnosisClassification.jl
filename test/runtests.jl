using DiagnosisClassification
using Test

@testset "DiagnosisClassification.jl" begin
    @testset "validate" begin
        include("validate/icd9.jl")
        include("validate/icd10.jl")
    end
    include("types.jl")
end
