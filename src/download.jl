function ensure_downloaded_files()
    global download_cache
    download_cache::String
    if isempty(readdir(download_cache))
        force_download_files(download_cache)
    end
    return download_cache::String
end

function force_download_files(dest_directory::AbstractString)
    let url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccs/AppendixASingleDX.txt"
        @info "Downloading files for CCS9"
        sleep(3) # Sleep for a bit, so that we can be compliant with any rate limits
        src = Downloads.download(url)
        dest_filename = "ccs9.txt"
        dest = joinpath(
            dest_directory,
            dest_filename,
        )
        mv(src, dest; force = true)
    end
    let url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR_v2022-1.zip"
        @info "Downloading files for CCS10"
        sleep(3) # Sleep for a bit, so that we can be compliant with any rate limits
        downloaded_filename = Downloads.download(url)
        dest_filename = "ccs10.csv"
        dest = joinpath(
            dest_directory,
            dest_filename,
        )
        _extract_zip_file(downloaded_filename) do extraction_output_dir
            src = joinpath(extraction_output_dir, "DXCCSR_v2022-1.CSV")
            mv(src, dest)
        end
    end
    return nothing
end

function _extract_zip_file(
        f::F,
        zip_file::AbstractString,
    ) where {F <: Function}
    mktempdir() do extraction_output_dir
        cd(extraction_output_dir) do
            extraction_cmd = `$(Pkg.PlatformEngines.exe7z())`
            push!(extraction_cmd.exec, "x")
            push!(extraction_cmd.exec, "$(zip_file)")
            push!(extraction_cmd.exec, "-o$(extraction_output_dir)")
            run(extraction_cmd)
            f(extraction_output_dir)
        end
    end
    return nothing
end
