use Mix.Config

alias Comspec.{Event}

config :comspecs, Account1,
  # meta-data
  spec_name: "Account",
  spec_shortdoc: "Account comspec",
  spec_doc: nil,
  spec_run_before: nil,
  spec_run_after: nil,
  # specification
  aggregates: nil,
  commands: nil,
  command_handlers: nil,
  command_routers: nil,
  command_validators: nil,
  events: [
    %Event{name: "AccountOpened", fields: [:account_number, :initial_balance]},
    %Event{name: "AccountClosed", fields: [:account_number]},
    %Event{name: "AccountCredited", fields: [:account_number, :amount]},
    %Event{name: "AccountDebited", fields: [:account_number, :amount]}
  ],
  event_handlers: nil,
  event_projectors: nil,
  process_managers: nil,
  read_schemas: nil,
  read_queries: nil
