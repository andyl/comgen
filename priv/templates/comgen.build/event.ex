# <%= event.templates.lib.dest %>
defmodule <%= event.module_name %> do
  @derive Jason.Encoder

  defstruct [<%= event.string_fields %>] 
end
