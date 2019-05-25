# PhoenixCommanded

[Commanded][com] support for the [Phoenix Framework][phx]

This repo is to experiment with generators, templates etc. for rapid
development Phoenix/Commanded apps.

The generators use a file-system layout described in a [google doc][doc]. 

[doc]: https://docs.google.com/document/d/1wks-6lO_MVguOYkETUDRg4tPxHvVgIPCPxObwUHvj14/edit
[com]: https://github.com/commanded/commanded
[phx]: https://phoenixframework.org

## Installation

First, generate a Phoenix app:

    mix phx.new MyApp

Installed this package by adding `phoenix_commanded` to your list of
dependencies in `my_app/mix.exs`:

```elixir
def deps do
  [
    {:phoenix_commanded, git: "https://github.com/andyl/phoenix_commanded"}
  ]
end
```

## Near-Term Approach

Then add this block of text to your `config/confix.exs` file:

```elixir
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

case Mix.env do
  :test ->
    config :commanded,
      event_store_adapter: Commanded.EventStore.Adapters.InMemory

    config :commanded, Commanded.EventStore.Adapters.InMemory,
      serializer: Commanded.Serialization.JsonSerializer
  :_ ->
    config :eventstore, 
      columnn_data_type: "jsonb"
    config :eventstore, EventStore.Storage,
      serializer: EventStore.JsonbSerializer,
      types: EventStore.PostgresTypes,
      username: "postgres",
      password: "postgres",
      database: "bank_api_eventstore_dev",
      hostname: "localhost",
      pool_size: 10,
      pool_overflow: 5
end
```

Now run these commands:

```
$ mix do event_store.create, event_store.init
$ mix ecto.create

```

## Future Approach

```
$ mix phxcmd.init            
$ mix phxcmd.gen.html
$ mix phxcmd.gen.json
$ mix phxcmd.gen.context
```

## Mix Commands

phxcmd.init

- write configs to `config/commanded.exs` (templated for custom Estore name...)
- write one-liner `import_config("commanded.exs")` to `config/config.exs`
- run `mix do event_store.create, event_store.init`

phxcmd.gen.context

- template: generate commands, aggregates, handlers, processes
- template: generate api

gen.html

- run `mix.phxcmd.gen.context`
- run phx.gen.html without the context generation

gen.json

- run `mix.phxcmd.gen.context`
- run phx.gen.json without the context generation

