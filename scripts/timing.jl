module RTWeekend

using Dates: now

using Base: Iterators

const PROJ_DIR = "/home/chaitanya/dev/raytracing.github.io"
const BUILD_DIR = joinpath(PROJ_DIR, "build")
const TEMP_DIR = joinpath(PROJ_DIR, "temp")
const SCRIPTS_DIR = joinpath(PROJ_DIR, "scripts")
const DATA_DIR = joinpath(SCRIPTS_DIR, "data")
const BIN_PATH = joinpath(BUILD_DIR, "theRestOfYourLife")


const CLEAN = `make clean`
const RELEASE = `make release`

build() = build(nothing)

function build(optflags::Union{String,Nothing})
    if !isnothing(optflags)
        ENV["OPTFLAGS"] = optflags
    end
    cd(PROJ_DIR)
    run(CLEAN)
    run(RELEASE)
end

function run(widths, aspect_ratio::Real, thread_counts)
    heights = convert(typeof(widths), widths .* aspect_ratio)
    run(widths, heights, thread_counts)
end
function run(widths, heights::V, thread_counts) where {V<:AbstractArray{<:Integer}}
    itr = Iterators.product(widths, heights, thread_counts)
    data_filename = joinpath(DATA_DIR, "$(string(now())).csv")
    for (w, h, t) in itr
        run(pipeline(`build/theRestOfYourLife -w $(w) -h $(h) -n $(t)`, stdout=devnull, stderr=data_filename))
    end
    data_filename
end

end # module
