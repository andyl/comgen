# <%= filedata.templates.lib.dst %>

defmodule <%= filedata.module_long %> do
  defstruct [<%= filedata.string_fields %> ]
  <%= for item <- annotations.commands do %>
  alias <%= item.module_long %> <% end %> 
  <%= for item <- annotations.events do %>
  alias <%= item.module_long %> <% end %> 

  # ----- PUBLIC COMMAND API
    
  def execute(%Account{}, %OpenAccount{}) do
    %AccountOpened{ account_uuid: account_uuid, initial_balance: initial_balance }
  end
  
  # ----- STATE MUTATORS
  
  def apply( %Account{} = account, %AccountOpened{ account_uuid: account_uuid, initial_balance: initial_balance }) do
    %Account{ account | uuid: account_uuid, current_balance: initial_balance }
  end
end
