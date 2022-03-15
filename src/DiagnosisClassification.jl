module DiagnosisClassification

import CSV
import Downloads
import Pkg
import ProgressMeter
import Scratch
import TOML

include("types.jl")

include("dict_utils.jl")
include("download.jl")

include("convenience/icd9.jl")
include("convenience/icd10.jl")

include("dots/icd9.jl")
include("dots/icd10.jl")

include("init.jl")

include("TODO.jl")

end # module
