using DiagnosisClassification
using Test

import CSV

@testset "DiagnosisClassification.jl" begin
    include("download.jl")
    include("init.jl")

    @testset "convenience" begin
        include("convenience/icd9.jl")
        include("convenience/icd10.jl")
    end

    @testset "dots" begin
        include("dots/icd9.jl")
        include("dots/icd10.jl")
    end
end
