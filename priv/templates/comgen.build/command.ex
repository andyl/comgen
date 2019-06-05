# <%= submodule.templates.lib.dst %>
defmodule <%= submodule.module_long %> do
  @derive Jason.Encoder

  defstruct [<%= submodule.string_fields %>] 
end
