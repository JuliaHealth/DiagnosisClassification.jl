using DiagnosisClassification
using Test

import CSV

@testset "DiagnosisClassification.jl" begin
    include("dict_utils.jl")
    include("download.jl")
    include("init.jl")
    include("types.jl")

    @testset "convenience" begin
        include("convenience/icd9.jl")
        include("convenience/icd10.jl")
    end

    @testset "dots" begin
        include("dots/icd9.jl")
        include("dots/icd10.jl")
    end

    include("TODO.jl")
end
