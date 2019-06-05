use Mix.Config

alias Comspec.{Event}

config :comgen, Account1,
  # meta-data
  spec_name: "Accounts",
  spec_shortdoc: "Account comspec 1",
  spec_doc: nil,
  spec_run_before: nil,
  spec_run_after: nil,
  # specification
  aggregates: [
    %{name: "Account", fields: [:uuid, :current_balance]}
  ],
  commands: nil,
  command_handlers: nil,
  command_routers: nil,
  command_validators: nil,
  events: [
    %{name: "AccountOpened", fields: [:account_number, :initial_balance]},
    %{name: "AccountClosed", fields: [:account_number]},
    %{name: "AccountCredited", fields: [:account_number, :amount]},
    %{name: "AccountDebited", fields: [:account_number, :amount]}
  ],
  event_handlers: nil,
  event_projectors: nil,
  process_managers: nil,
  read_schemas: nil,
  read_queries: nil

#   Accounts: %{
#     aggregate: %{
#       BankAccount: %{
#         fields: [:account_number, :balance]
#       }
#     },
#     command: %{
#       OpenAccount: %{
#         fields: [:account_number, :initial_balance],
#         key_field: :account_number
#       }
#     },
#     command_handler: ["NoOpMiddleware"],
#     command_router: ["BankRouter"],
#     event_projector: ["ExampleProjector"],
#     read: %{
#       fields: ~w(name:string balance:integer)
#     },
#     saga: %{
#       TransferMoneyProcessManager: %{
#         fields: [:transfer_uuid, :debit_account, :credit_account, :amount, :status]
#       }
#     }
#   }
#   }
# }
#
# config :commanded, comspec: comspec
