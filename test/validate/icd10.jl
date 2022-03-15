@testset "icd10" begin
    _icd10_force_add_dots    = DiagnosisClassification._icd10_force_add_dots
    _icd10_force_remove_dots = DiagnosisClassification._icd10_force_remove_dots

    @testset "_icd10_force_add_dots" begin
        test_cases = [
            "W55"     => "W55",
            "W552"    => "W55.2",
            "W5529"   => "W55.29",
            "W5529X"  => "W55.29X",
            "W5529XA" => "W55.29XA",
            "Z67"     => "Z67",
            "Z674"    => "Z67.4",
            "Z6741"   => "Z67.41",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test _icd10_force_add_dots(input) == expected_output
        end
        @test_throws ErrorException _icd10_force_add_dots("")
    end
    @testset "_icd10_force_remove_dots" begin
        test_cases=[
            "W55"      => "W55",
            "W55.2"    => "W552",
            "W55.29"   => "W5529",
            "W55.29X"  => "W5529X",
            "W55.29XA" => "W5529XA",
            "Z67"      => "Z67",
            "Z67.4"    => "Z674",
            "Z67.41"   => "Z6741",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test _icd10_force_remove_dots(input) == expected_output
        end
        @test_throws ErrorException _icd10_force_remove_dots("")
    end
    @testset "Roundtrip _icd10_force_add_dots" begin
        test_cases=[
            "W55",
            "W552",
            "W5529",
            "W5529X",
            "W5529XA",
            "Z67",
            "Z674",
            "Z6741",
        ]
        for input in test_cases
            @test _icd10_force_remove_dots(_icd10_force_add_dots(input)) == input
        end
    end
    @testset "Roundtrip _icd10_force_remove_dots" begin
        test_cases=[
            "W55",
            "W55.2",
            "W55.29",
            "W55.29X",
            "W55.29XA",
            "Z67",
            "Z67.4",
            "Z67.41",
        ]
        for input in test_cases
            @test _icd10_force_add_dots(_icd10_force_remove_dots(input)) == input
        end
    end
end
