@testset "dict_utils" begin
    setindex_no_overwrite! = DiagnosisClassification.setindex_no_overwrite!
    setindex_same_value!   = DiagnosisClassification.setindex_same_value!

    @testset "setindex_no_overwrite!" begin
        dict = Dict{String, String}()
        @test setindex_no_overwrite!(dict, "hello", "world") isa Nothing
        @test_throws ErrorException setindex_no_overwrite!(dict, "hello", "world2")
    end

    @testset "setindex_same_value!" begin
        dict = Dict{String, String}()
        @test setindex_same_value!(dict, "hello", "world") isa Nothing
        @test setindex_same_value!(dict, "hello", "world") isa Nothing
        @test setindex_same_value!(dict, "hello", "world") isa Nothing
        @test_throws ErrorException setindex_same_value!(dict, "hello", "world2")
    end
end
