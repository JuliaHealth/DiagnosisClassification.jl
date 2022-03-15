@testset "icd9" begin
    _icd9_force_add_dots    = DiagnosisClassification._icd9_force_add_dots
    _icd9_force_remove_dots = DiagnosisClassification._icd9_force_remove_dots

    @testset "_icd9_force_add_dots" begin
        test_cases = [
            "003"   => "003",
            "0032"  => "003.2",
            "00320" => "003.20",
            "V01"   => "V01",
            "V017"  => "V01.7",
            "V0171" => "V01.71",
            "E000"  => "E000",
            "E0000" => "E000.0",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test _icd9_force_add_dots(input) == expected_output
        end
        @test_throws ErrorException _icd9_force_add_dots("")
    end
    @testset "_icd9_force_remove_dots" begin
        test_cases = [
            "003"    => "003",
            "003.2"  => "0032",
            "003.20" => "00320",
            "V01"    => "V01",
            "V01.7"  => "V017",
            "V01.71" => "V0171",
            "E000"   => "E000",
            "E000.0" => "E0000",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test _icd9_force_remove_dots(input) == expected_output
        end
        @test_throws ErrorException _icd9_force_remove_dots("")
    end
    @testset "Roundtrip _icd9_force_add_dots" begin
        test_cases = [
            "003",
            "0032",
            "00320",
            "V01",
            "V017",
            "V0171",
            "E000",
            "E0000",
        ]
        for input in test_cases
            @test _icd9_force_remove_dots(_icd9_force_add_dots(input)) == input
        end
    end
    @testset "Roundtrip _icd9_force_remove_dots" begin
        test_cases = [
            "003",
            "003.2",
            "003.20",
            "V01",
            "V01.7",
            "V01.71",
            "E000",
            "E000.0",
        ]
        for input in test_cases
            @test _icd9_force_add_dots(_icd9_force_remove_dots(input)) == input
        end
    end
end
