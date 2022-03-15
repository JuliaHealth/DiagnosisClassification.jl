module DiagnosisClassification

import CSV
import Downloads
import Pkg
import Scratch
import TOML

include("types.jl")

include("download.jl")

include("convenience/icd9.jl")
include("convenience/icd10.jl")

include("dots/icd9.jl")
include("dots/icd10.jl")

include("init.jl")

end # module
