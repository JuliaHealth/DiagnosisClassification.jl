@testset "init" begin
    _initialize_download_cache = DiagnosisClassification._initialize_download_cache
    @test _initialize_download_cache() isa Nothing
end
