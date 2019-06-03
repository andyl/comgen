use Mix.Config

# Experimental Comspec

config :comspecs, Experimental,
  spec_name: nil,
  spec_shortdoc: "Experimental comspec",
  spec_doc: nil,
  spec_run_before: nil,
  spec_run_after: nil,

  aggregates: nil,
  commands: nil,
  command_handlers: nil,
  command_routers: nil,
  command_validators: nil,
  events: nil,
  event_handlers: nil,
  event_projectors: nil,
  process_managers: nil,
  read_schemas: nil,
  read_queries: nil

# comspec = %{
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
#     event: %{
#       BankAccountOpened: [:account_number, :initial_balance]
#     },
#     event_projector: ["ExampleProjector"],
#     read: %{
#       fields: ~w(name:string balance:integer)
#     },
#     saga: %{
#       TransferMoneyProcessManager: %{
#         fields: [:transfer_uuid, :debit_account, :credit_account, :amount, :status]
#       }
#     }
#   },
#   Users: %{
#     aggregate: [],
#     command: [],
#     event: [],
#     read: [],
#     saga: []
#   }
# }
#
# config :commanded, comspec: comspec
