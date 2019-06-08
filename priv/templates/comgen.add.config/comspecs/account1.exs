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
          cmd_params: "uuid: uuid, amount: amount",
          ev_name: "AccountOpened",
          ev_params: "uuid: uuid, amount: amount"
        },
        %{
          cmd_name: "CloseAccount",
          cmd_params: "uuid: uuid",
          ev_name: "AccountClosed",
          ev_params: "uuid: uuid"
        },
        %{
          cmd_name: "CreditAccount",
          cmd_params: "uuid: uuid, amount: amount",
          ev_name: "AccountCredited",
          ev_params: "uuid: uuid, amount: amount"
        },
        %{
          cmd_name: "DebitAccount",
          cmd_params: "uuid: uuid, amount: amount",
          ev_name: "AccountDebited",
          ev_params: "uuid: uuid, amount: amount"
        }
      ],
      mutators: [
        %{
          ev_name: "AccountOpened",
          ev_params: "uuid: uuid, amount: amount",
          old_state: "account",
          new_state: "account | uuid: uuid, balance: amount"
        },
        %{
          ev_name: "AccountClosed",
          ev_params: "uuid: uuid",
          old_state: "account",
          new_state: "account | uuid: uuid, balance: 0"
        },
        %{
          ev_name: "AccountCredited",
          ev_params: "uuid: uuid, amount: amount",
          old_state: "account",
          new_state: "account | amount: amount"
        },
        %{
          ev_name: "AccountDebited",
          ev_params: "uuid: uuid, amount: amount",
          old_state: "account",
          new_state: "account | amount: amount"
        },
      ],
    }
  ],
  commands: [
    %{name: "OpenAccount", fields: [:uuid, :amount]},
    %{name: "CloseAccount", fields: [:uuid]},
    %{name: "CreditAccount", fields: [:uuid, :amount]},
    %{name: "DebitAccount", fields: [:uuid, :amount]}
  ],
  command_handlers: nil,
  command_routers: nil,
  command_validators: nil,
  events: [
    %{name: "AccountOpened", fields: [:uuid, :amount]},
    %{name: "AccountClosed", fields: [:uuid]},
    %{name: "AccountCredited", fields: [:uuid, :amount]},
    %{name: "AccountDebited", fields: [:uuid, :amount]}
  ],
  event_handlers: nil,
  event_projectors: nil,
  process_managers: nil,
  read_schemas: nil,
  read_queries: nil
