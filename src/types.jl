Base.@kwdef struct Class
    domain::String
    system::String
    value::String
end

function DiagnosisClass(; system, value)
    domain = "diagnosis"
    class = Class(; domain, system, value)
    return class
end
