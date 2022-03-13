using DiagnosisClassification
using Documenter

DocMeta.setdocmeta!(DiagnosisClassification, :DocTestSetup, :(using DiagnosisClassification); recursive=true)

makedocs(;
    modules=[DiagnosisClassification],
    authors="Dilum Aluthge, Brown Center for Biomedical Informatics, contributors",
    repo="https://github.com/JuliaHealth/DiagnosisClassification.jl/blob/{commit}{path}#{line}",
    sitename="DiagnosisClassification.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaHealth.github.io/DiagnosisClassification.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
    strict=true,
)

deploydocs(;
    repo="github.com/JuliaHealth/DiagnosisClassification.jl",
    devbranch="main",
)
