# <%= event.templates.lib.dest %>
defmodule <%= event.module_name %> do
  @derive Json.Encoder

  defstruct [<%= event.string_fields %>] 
end
