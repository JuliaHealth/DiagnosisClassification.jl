function generate_ccs9_to_icd9(download_cache = ensure_downloaded_files())
    ccs_filename = joinpath(download_cache, "ccs9.txt")
    ccs_filecontents = strip(read(ccs_filename, String)::String)
    elements = strip.(split(ccs_filecontents, "\n\n"))
    ccs9_to_icd9            = Dict{DiagnosisClass, Set{DiagnosisClass}}()
    ccs9_to_ccs_description = Dict{DiagnosisClass, String}()
    ProgressMeter.@showprogress for element in elements
        if startswith(element, "Appendix A - ")
            continue
        end
        if startswith(element, "Revised ")
            continue
        end
        element2 = replace(element, '`' => ''')
        r = r"^(\d\d*?)\s\s*?([A-Za-z() :;,\-'\/]*?)\s*?\n([\S\s]*?)$"
        m = match(r, element2)
        (m === nothing) && @error("Could not parse element", element2)
        ccs_value       = strip(m[1])
        ccs_description = strip(m[2])
        ccs_node = construct_ccs9(ccs_value)
        icd_values = strip.(split(strip(replace(m[3], '\n' => ' ')), ' '))
        filter!(x -> !isempty(x), icd_values)
        icd_nodes = DiagnosisClassification.construct_icd9.(icd_values)
        icd_set = Set{DiagnosisClassification.DiagnosisClass}(icd_nodes)
        setindex_no_overwrite!(
            ccs9_to_icd9,
            ccs_node,
            icd_set,
        )
        setindex_no_overwrite!(
            ccs9_to_ccs_description,
            ccs_node,
            ccs_description,
        )
    end
    return (; ccs9_to_icd9, ccs9_to_ccs_description)
end

function generate_ccs10_to_icd10(download_cache = ensure_downloaded_files())
    ccs_filename = joinpath(download_cache, "ccs10.csv")
    ccs_file = CSV.File(ccs_filename)
    all_column_names_str = String.(ccs_file.names)
    unique!(all_column_names_str)
    sort!(all_column_names_str)
    ccs_column_names_str = filter(
        x -> startswith(x, "'CCSR CATEGORY ") && !occursin("DESCRIPTION", x),
        all_column_names_str,
    )
    unique!(ccs_column_names_str)
    sort!(ccs_column_names_str)
    remove_single_quotes = x -> begin
        r = r"^'(.*?)'$"
        m = match(r, x)
        (m === nothing) && @error("Could not parse", x)
        return convert(String, m[1])::String
    end
    ccscolname_to_ccsdesccolname = x -> begin
        return "'" * remove_single_quotes(x) * " DESCRIPTION'"
    end
    if length(ccs_column_names_str) < 1
        msg = "Not enough CCS category columns"
        @error msg ccs_column_names_str
        throw(ErrorException(msg))
    end

    ccs10_to_icd10           = Dict{DiagnosisClass, Set{DiagnosisClass}}()
    ccs10_to_ccs_description = Dict{DiagnosisClass, String}()
    ProgressMeter.@showprogress for row in ccs_file
        icd_value = remove_single_quotes(row[Symbol("'ICD-10-CM CODE'")])
        icd_node  = construct_icd10(icd_value)
        for ccscolname in ccs_column_names_str
            ccs_value = row[Symbol(ccscolname)] |> remove_single_quotes |> strip
            if isempty(ccs_value)
                continue
            end
            ccs_node = construct_ccs10(ccs_value)
            if !haskey(ccs10_to_icd10, ccs_node)
                ccs10_to_icd10[ccs_node] = Set{DiagnosisClass}()
            end
            push!(ccs10_to_icd10[ccs_node], icd_node)

            ccsdesccolname = ccscolname_to_ccsdesccolname.(ccscolname)
            ccs_description = row[Symbol(ccsdesccolname)] |> strip
            setindex_same_value!(
                ccs10_to_ccs_description,
                ccs_node,
                ccs_description,
            )
        end
    end

    return (; ccs10_to_icd10, ccs10_to_ccs_description)
end
