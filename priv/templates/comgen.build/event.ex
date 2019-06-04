# event.ex
# UNDER CONSTRUCTION
defmodule <%= Comspec.Event.name %> do
  @derive Json.Encoder

  defstruct [<%= Comspec.Event.events %>]
end
