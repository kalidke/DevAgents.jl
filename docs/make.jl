using DevAgents
using Documenter

DocMeta.setdocmeta!(DevAgents, :DocTestSetup, :(using DevAgents); recursive=true)

makedocs(;
    modules=[DevAgents],
    authors="klidke@unm.edu",
    sitename="DevAgents.jl",
    format=Documenter.HTML(;
        canonical="https://kalidke.github.io/DevAgents.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kalidke/DevAgents.jl",
    devbranch="main",
)
