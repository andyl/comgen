use Mix.Config

# This comspec is inspired by the series "Event Sourcing with Elixir" by Bruno
# Antunes.  https://blog.nootch.net/post/event-sourcing-with-elixir/

config :comgen, EventSourcingElixir,

  spec_name: "EseAccounts",
  spec_shortdoc: "Event Sourcing with Elixir",
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

