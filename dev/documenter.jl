# Show basic docstrings generator 

using Revise
using AnthropicAPI
using DevAgents
using JSON
DA = DevAgents

# setup api info 
api_info = AnthropicAPI.API_Info(;max_tokens = 2000)
docstrg = DevAgents.suggest_docstrings(api_info, "src/documenter.jl")

str = docstrg.messages[end].content[1].text
str_json = DA.extract_json(str)

elements = JSON.parse(str_json)


