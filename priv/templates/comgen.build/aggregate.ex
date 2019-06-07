# <%= filedata.templates.lib.dst %>

defmodule <%= filedata.module_long %> do
  defstruct [<%= filedata.string_fields %>

  alias <%= filedata.module_long %>
  # alias BankAPI.Accounts.Commands.OpenAccount
  # alias BankAPI.Accounts.Events.AccountOpened

  # ----- PUBLIC COMMAND API
    
  # def execute(
  #       %Account{uuid: nil},
  #       %OpenAccount{
  #         account_uuid: account_uuid,
  #         initial_balance: initial_balance
  #       }
  #     )
  #     when initial_balance > 0 do
  #   %AccountOpened{
  #     account_uuid: account_uuid,
  #     initial_balance: initial_balance
  #   }
  # end
  
  # def execute(
  #       %Account{uuid: nil},
  #       %OpenAccount{
  #         initial_balance: initial_balance
  #       }
  #     )
  #     when initial_balance <= 0 do
  #   {:error, :initial_balance_must_be_above_zero}
  # end
  
  # def execute(%Account{}, %OpenAccount{}) do
  #   {:error, :account_already_opened}
  # end
  
  # ----- STATE MUTATORS
  
  # def apply(
  #       %Account{} = account,
  #       %AccountOpened{
  #         account_uuid: account_uuid,
  #         initial_balance: initial_balance
  #       }
  #     ) do
  #   %Account{
  #     account
  #     | uuid: account_uuid,
  #       current_balance: initial_balance
  #   }
  # end
end
