@testset "TODO: fix this code" begin
    DiagnosisClass          = DiagnosisClassification.DiagnosisClass
    generate_ccs9_to_icd9   = DiagnosisClassification.generate_ccs9_to_icd9
    construct_icd9          = DiagnosisClassification.construct_icd9
    construct_ccs9          = DiagnosisClassification.construct_ccs9
    generate_ccs10_to_icd10 = DiagnosisClassification.generate_ccs10_to_icd10
    construct_icd10         = DiagnosisClassification.construct_icd10
    construct_ccs10         = DiagnosisClassification.construct_ccs10

    @testset "generate_ccs9_to_icd9" begin
        ccs9_to_icd9_struct     = generate_ccs9_to_icd9()
        ccs9_to_icd9            = ccs9_to_icd9_struct.ccs9_to_icd9
        ccs9_to_ccs_description = ccs9_to_icd9_struct.ccs9_to_ccs_description
        @test ccs9_to_icd9            isa Dict{DiagnosisClass, Set{DiagnosisClass}};
        @test ccs9_to_ccs_description isa Dict{DiagnosisClass, String};
        @test !isempty(ccs9_to_icd9);
        @test !isempty(ccs9_to_ccs_description);
        @test ccs9_to_ccs_description[construct_ccs9("1")] == "Tuberculosis"
        @test ccs9_to_ccs_description[construct_ccs9("1")] != "Septicemia"
        @test construct_icd9("011.00")  in ccs9_to_icd9[construct_ccs9("1")];
        @test !(construct_icd9("031.2") in ccs9_to_icd9[construct_ccs9("1")]);
    end

    @testset "generate_ccs10_to_icd10" begin
        ccs10_to_icd10_struct    = generate_ccs10_to_icd10()
        ccs10_to_icd10           = ccs10_to_icd10_struct.ccs10_to_icd10
        ccs10_to_ccs_description = ccs10_to_icd10_struct.ccs10_to_ccs_description
        @test ccs10_to_icd10           isa Dict{DiagnosisClass, Set{DiagnosisClass}};
        @test ccs10_to_ccs_description isa Dict{DiagnosisClass, String};
        @test !isempty(ccs10_to_icd10);
        @test !isempty(ccs10_to_ccs_description);
        @test ccs10_to_ccs_description[construct_ccs10("INF001")] == "Tuberculosis"
        @test ccs10_to_ccs_description[construct_ccs10("INF001")] != "Septicemia"
        @test construct_icd10("A15.7") in ccs10_to_icd10[construct_ccs10("INF001")];
        @test !(construct_icd10("A31.2") in ccs10_to_icd10[construct_ccs10("INF001")]);
    end
end
