function generate_ccs9_to_icd9(download_cache = ensure_downloaded_files())
    ccs9_filename = joinpath(download_cache, "ccs9.txt")
    ccs9_filecontents = strip(read(ccs9_filename, String)::String)
    elements = strip.(split(ccs9_filecontents, "\n\n"))
    ccs9_to_icd9 = Dict{DiagnosisClass, Set{DiagnosisClass}}()
    ccs9_to_ccs_description = Dict{DiagnosisClass, String}()
    for element in elements
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
        icd9_values = strip.(split(strip(replace(m[3], '\n' => ' ')), ' '))
        filter!(x -> !isempty(x), icd9_values)
        icd9_nodes = DiagnosisClassification.construct_icd9.(icd9_values)
        icd9_set = Set{DiagnosisClassification.DiagnosisClass}(icd9_nodes)
        setindex_no_overwrite!(
            ccs9_to_icd9,
            ccs_node,
            icd9_set,
        )
        setindex_no_overwrite!(
            ccs9_to_ccs_description,
            ccs_node,
            ccs_description,
        )
    end
    return (; ccs9_to_icd9, ccs9_to_ccs_description)
end
