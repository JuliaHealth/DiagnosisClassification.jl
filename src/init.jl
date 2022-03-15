const _package_version = Base.VersionNumber(
    TOML.parsefile(joinpath(dirname(@__DIR__), "Project.toml"))["version"]
)

function _initialize_download_cache()
    folder_name = "downloaded_files-$(_package_version)"
    global download_cache = Scratch.get_scratch!(@__MODULE__, folder_name)
    return nothing
end

function __init__()
    _initialize_download_cache()
    return nothing
end
