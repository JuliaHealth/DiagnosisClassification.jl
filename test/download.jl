@testset "download" begin
    ensure_downloaded_files = DiagnosisClassification.ensure_downloaded_files
    force_download_files    = DiagnosisClassification.force_download_files

    @test ensure_downloaded_files() isa String
    @test ensure_downloaded_files() isa String

    mktempdir() do dir
        @test force_download_files(dir) isa Nothing
    end

    ccs9_filename = joinpath(ensure_downloaded_files(), "ccs9.txt")
    ccs10_filename = joinpath(ensure_downloaded_files(), "ccs10.csv")
    @test isfile(ccs9_filename)
    @test isfile(ccs10_filename)
    @test !isempty(strip(read(ccs9_filename, String)));
    @test !isempty(strip(read(ccs10_filename, String)));
    ccs10_file = CSV.File(ccs10_filename)
    @test length(ccs10_file) > 100
    @test length(ccs10_file[1]) > 5
end
