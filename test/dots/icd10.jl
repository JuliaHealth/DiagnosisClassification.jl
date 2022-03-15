@testset "icd10" begin
    icd10_add_dots    = DiagnosisClassification.icd10_add_dots
    icd10_remove_dots = DiagnosisClassification.icd10_remove_dots

    @testset "icd10_add_dots" begin
        test_cases = [
            # Input is too short for a dot
            "W55"      => "W55",
            "Z67"      => "Z67",

            # Input contains a dot
            "W55.2"    => "W55.2",
            "W55.29"   => "W55.29",
            "W55.29X"  => "W55.29X",
            "W55.29XA" => "W55.29XA",
            "Z67.4"    => "Z67.4",
            "Z67.41"   => "Z67.41",

            # Input does not contain a dot
            "W552"     => "W55.2",
            "W5529"    => "W55.29",
            "W5529X"   => "W55.29X",
            "W5529XA"  => "W55.29XA",
            "Z674"     => "Z67.4",
            "Z6741"    => "Z67.41",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd10_add_dots(input) == expected_output
        end
        @test_throws ErrorException icd10_add_dots("")
    end

    @testset "icd10_remove_dots" begin
        test_cases = [
            # Input is too short for a dot
            "W55"      => "W55",
            "Z67"      => "Z67",

            # Input contains a dot
            "W55.2"    => "W552",
            "W55.29"   => "W5529",
            "W55.29X"  => "W5529X",
            "W55.29XA" => "W5529XA",
            "Z67.4"    => "Z674",
            "Z67.41"   => "Z6741",

            # Input does not contain a dot
            "W552"     => "W552",
            "W5529"    => "W5529",
            "W5529X"   => "W5529X",
            "W5529XA"  => "W5529XA",

            "Z674"     => "Z674",
            "Z6741"    => "Z6741",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd10_remove_dots(input) == expected_output
        end
        @test_throws ErrorException icd10_remove_dots("")
    end

    @testset "Roundtrip icd10_add_dots" begin
        test_cases = [
            # Input is too short for a dot
            "W55"      => "W55",
            "Z67"      => "Z67",

            # Input contains a dot
            "W55.2"    => "W552",
            "W55.29"   => "W5529",
            "W55.29X"  => "W5529X",
            "W55.29XA" => "W5529XA",
            "Z67.4"    => "Z674",
            "Z67.41"   => "Z6741",

            # Input does not contain a dot
            "W552"     => "W552",
            "W5529"    => "W5529",
            "W5529X"   => "W5529X",
            "W5529XA"  => "W5529XA",
            "Z674"     => "Z674",
            "Z6741"    => "Z6741",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd10_remove_dots(icd10_add_dots(input)) == expected_output
        end
    end

    @testset "Roundtrip icd10_remove_dots" begin
        test_cases = [
            # Input is too short for a dot
            "W55"      => "W55",
            "Z67"      => "Z67",

            # Input contains a dot
            "W55.2"    => "W55.2",
            "W55.29"   => "W55.29",
            "W55.29X"  => "W55.29X",
            "W55.29XA" => "W55.29XA",
            "Z67.4"    => "Z67.4",
            "Z67.41"   => "Z67.41",

            # Input does not contain a dot
            "W552"     => "W55.2",
            "W5529"    => "W55.29",
            "W5529X"   => "W55.29X",
            "W5529XA"  => "W55.29XA",
            "Z674"     => "Z67.4",
            "Z6741"    => "Z67.41",
        ]
        for test_case in test_cases
            input           = test_case[1]
            expected_output = test_case[2]
            @test icd10_add_dots(icd10_remove_dots(input)) == expected_output
        end
    end
end
