@testset "dict_utils" begin
    setindex_no_overwrite! = DiagnosisClassification.setindex_no_overwrite!
    dict = Dict{String, String}()
    @test setindex_no_overwrite!(dict, "hello", "world") isa Nothing
    @test_throws ErrorException setindex_no_overwrite!(dict, "hello", "world2")
end
