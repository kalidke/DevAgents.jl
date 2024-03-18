"""
    Load the content of a file into a string.
"""
function load_file(file_path::String)
    return read(file_path, String)
end

"""
    Find and extract the JSON content from a string.
"""


function extract_json(string_with_json::String)
    # Find the positions of the first '{' and last '}'
    first_brace_index = findfirst('{', string_with_json)
    last_brace_index = findlast('}', string_with_json)

    if first_brace_index !== nothing && last_brace_index !== nothing
        # Extract the JSON substring
        json_string = string_with_json[first_brace_index:last_brace_index]
        println("JSON data found: ", json_string )
        try
            # Parse the JSON string into a Julia object
            json_data = JSON.parse(json_string)
            return json_data
        catch e
            # Handle JSON parsing errors
            println("Error parsing JSON data: ", e)
            return nothing
        end
    else
        println("No JSON data found in the string.")
        return nothing
    end
end
