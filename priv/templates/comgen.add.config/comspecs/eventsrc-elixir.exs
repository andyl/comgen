use Mix.Config

# This comspec is inspired by the series "Event Sourcing with Elixir" by Bruno
# Antunes.  https://blog.nootch.net/post/event-sourcing-with-elixir/

config :comspecs, EventSourcingElixir,
  aggregates: nil,
  commands: nil,
  command_handlers: nil,
  command_routers: nil,
  command_validators: nil,
  events: nil,
  event_handlers: nil,
  event_projectors: nil,
  process_managers: nil,
  read: nil,
  spec_name: nil,
  spec_doc: nil,
  spec_run_before: nil,
  spec_run_after: nil

