
# uses the AntropicAPI package to parse the source code and extract the elements that can be documented 

function suggest_docstrings(api_info::API_Info, file_path::String)
    # read file 
    filestring = load_file(file_path)

    # setup system prompt for the AntropicAPI
    system_prompt = 
    """
    You are an AI assistant named CodeDoc, specialized in analyzing and improving the documentation of Julia code. 
    Your purpose is to enhance the quality and maintainability of Julia code by ensuring that all relevant functions, 
    structs, and types have clear and informative docstrings.
    """

    user_prompt = """
    CodeDoc, I need your help in improving the docstrings of a Julia code file. Please perform the following tasks:

    1. Analyze the provided code and identify all the functions, structs, and types that should have docstrings.
    
    2. For each identified entity, check if it already has a docstring. If present, evaluate the quality and completeness of the existing docstring.
    
    3. For entities with missing or incomplete docstrings, generate new or updated docstrings based on the following guidelines:
       - Use the surrounding code, function signatures, argument types, return values, and any existing comments as context for generating the docstrings.
       - Ensure that the generated docstrings are clear, concise, and provide sufficient information about the purpose, parameters, and return values of the entities.
       - Follow Julia's documentation conventions and best practices for docstring formatting and content. Juila docstrings go above the function definition and are enclosed in triple quotes.
    
    4. Once you have generated the necessary docstrings, insert them into the appropriate locations in the code, maintaining proper indentation and formatting.
    
    5. Prepare a summary of the changes made to the code, including:
       - The total number of entities identified for docstring generation.
       - The count of new docstrings added and existing docstrings updated.
       - Highlight any significant improvements or enhancements made to the code's documentation.
    
    Please provide the updated code with the newly inserted docstrings, along with the summary of changes, in the following JSON format.
    Do not make any comment or return anything before or after the JSON object.
    
    {"
  "updated_code": "\"\"\"\nContains utility functions for string manipulation.\n\"\"\"\nmodule MyModule\n\n
  
  \"\"\"
  reverse_string(str::String) -> String

  Reverse the order of characters in a string.

  Args:
    - str::String: The input string to be reversed.

  Returns:
    - String: The reversed string.
  \"\"\"
  function reverse_string(str::String)
    return join(reverse(collect(str)))
  end

  \"\"\"
  capitalize_words(str::String) -> String

  Capitalize the first letter of each word in a string.

  Args:
    - str::String: The input string to be capitalized.

  Returns:
    - String: The string with each word capitalized.
  \"\"\"
  function capitalize_words(str::String)
    return join(uppercasefirst.(split(str)), \" \")
  end
",

  "summary": {
    "total_entities": 3,
    "new_docstrings_added": 3,
    "existing_docstrings_updated": 0,
    "improvements": [
      "Add docstring for the `MyModule` module.",
      "Include function signatures with types inside the docstring blocks.",
      "Place function signatures above the one-line descriptions in the docstrings.",
      "Follow Julia's documentation conventions in docstrings.",
      "Provide clear descriptions of functions, arguments, and return values in docstrings."
    ]
  }
}

    Thank you for your assistance, CodeDoc! Your expertise in improving Julia code documentation is greatly appreciated.

    Here is the Julia code file for analysis:

"""

      # call the AntropicAPI to extract the elements
    conv = AnthropicAPI.Conversation(system_prompt, user_prompt *filestring)

    query!(conv,api_info)
    
    # parse the response from JSON to Vector of strings 
    #elements = JSON.parse(conv.messages[end])
    return conv

end

