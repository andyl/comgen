# <%= event.templates.lib.dest %>
defmodule <%= event.module_long %> do
  @derive Jason.Encoder

  defstruct [<%= event.string_fields %>] 
end
