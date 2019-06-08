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
    %{
      name: "Account",
      fields: [:uuid, :balance],
      api: [
        %{
          cmd_name: "OpenAccount",
          cmd_params: "uuid: uuid, balance: balance",
          ev_name: "AccountOpened",
          ev_params: "uuid: uuid, balance: balance"
        },
        %{
          cmd_name: "CloseAccount",
          cmd_params: "uuid: uuid, balance: balance",
          ev_name: "AccountClosed",
          ev_params: "uuid: uuid, balance: balance"
        },
        %{
          cmd_name: "CreditAccount",
          cmd_params: "",
          ev_name: "AccountCredited",
          ev_params: ""
        },
        %{
          cmd_name: "DebitAccount",
          cmd_params: "",
          ev_name: "AccountDebited",
          ev_params: ""
        }
      ]
    }
  ],
  commands: [
    %{name: "OpenAccount", fields: [:account_number, :initial_balance]},
    %{name: "CloseAccount", fields: [:account_number]},
    %{name: "CreditAccount", fields: [:account_number, :amount]},
    %{name: "DebitAccount", fields: [:account_number, :amount]}
  ],
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
