# <%= filedata.templates.lib.dst %>
defmodule <%= filedata.module_long %> do
  @derive Jason.Encoder

  defstruct [<%= filedata.string_fields %>] 
end
