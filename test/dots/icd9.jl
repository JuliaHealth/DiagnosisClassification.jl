@testset "icd9" begin
    icd9_add_dots    = DiagnosisClassification.icd9_add_dots
    icd9_remove_dots = DiagnosisClassification.icd9_remove_dots

    @testset "icd9_add_dots" begin
        test_cases = [
            # Input is too short for a dot
            "003"    => "003",
            "V01"    => "V01",
            "E000"   => "E000",

            # Input contains a dot
            "003.2"  => "003.2",
            "003.20" => "003.20",
            "V01.7"  => "V01.7",
            "V01.71" => "V01.71",
            "E000.0" => "E000.0",

            # Input does not contain a dot
            "0032"   => "003.2",
            "00320"  => "003.20",
            "V017"   => "V01.7",
            "V0171"  => "V01.71",
            "E0000"  => "E000.0",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd9_add_dots(input) == expected_output
        end
        @test_throws ErrorException icd9_add_dots("")
    end

    @testset "icd9_remove_dots" begin
        test_cases = [
            # Input is too short for a dot
            "003"    => "003",
            "V01"    => "V01",
            "E000"   => "E000",

            # Input contains a dot
            "003.2"  => "0032",
            "003.20" => "00320",
            "V01.7"  => "V017",
            "V01.71" => "V0171",
            "E000.0" => "E0000",

            # Input does not contain a dot
            "0032"   => "0032",
            "00320"  => "00320",
            "V017"   => "V017",
            "V0171"  => "V0171",
            "E0000"  => "E0000",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd9_remove_dots(input) == expected_output
        end
        @test_throws ErrorException icd9_remove_dots("")
    end

    @testset "Roundtrip icd9_add_dots" begin
        test_cases = [
            # Input is too short for a dot
            "003"    => "003",
            "V01"    => "V01",
            "E000"   => "E000",

            # Input contains a dot
            "003.2"  => "0032",
            "003.20" => "00320",
            "V01.7"  => "V017",
            "V01.71" => "V0171",
            "E000.0" => "E0000",

            # Input does not contain a dot
            "0032"   => "0032",
            "00320"  => "00320",
            "V017"   => "V017",
            "V0171"  => "V0171",
            "E0000"  => "E0000",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd9_remove_dots(icd9_add_dots(input)) == expected_output
        end
    end

    @testset "Roundtrip icd9_remove_dots" begin
        test_cases = [
            # Input is too short for a dot
            "003"    => "003",
            "V01"    => "V01",
            "E000"   => "E000",

            # Input contains a dot
            "003.2"  => "003.2",
            "003.20" => "003.20",
            "V01.7"  => "V01.7",
            "V01.71" => "V01.71",
            "E000.0" => "E000.0",

            # Input does not contain a dot
            "0032"   => "003.2",
            "00320"  => "003.20",
            "V017"   => "V01.7",
            "V0171"  => "V01.71",
            "E0000"  => "E000.0",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd9_add_dots(icd9_remove_dots(input)) == expected_output
        end
    end
end
