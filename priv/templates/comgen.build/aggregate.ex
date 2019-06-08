# <%= filedata.templates.lib.dst %>
defmodule <%= filedata.module_long %> do
  defstruct [<%= filedata.string_fields %> ]

  alias <%= filedata.module_long %>
  <%= for command <- annotations.commands do %>
  alias <%= command.module_long %> <% end %> 
  <%= for event <- annotations.events do %>
  alias <%= event.module_long %> <% end %> 

  # ----- PUBLIC COMMAND API
  <%= for cmd <- filedata.api do %> 
  def execute(%<%= filedata.name %>{}, %<%= cmd.cmd_name %>{<%= cmd.cmd_params %>}) do
    # your code here
    %<%= cmd.ev_name %>{<%= cmd.ev_params %>}
  end
  <% end %>
  # ----- STATE MUTATORS
  <%= for event <- filedata.mutators do %> 
  def account(%<%= filedata.name %>{} = <%= event.old_state %>, %<%= event.ev_name %>{<%= event.ev_params %>}) do
    # your code here
    %<%= event.ev_name %>{<%= event.old_state %> | <%= event.ev_params %>}
  end
  <% end %>
end
