use Mix.Config

case Mix.env() do
  :test ->
    config :commanded,
      event_store_adapter: Commanded.EventStore.Adapters.InMemory

    config :commanded, Commanded.EventStore.Adapters.InMemory,
      serializer: Commanded.Serialization.JsonSerializer

  _ ->
    config :commanded,
      event_store_adapter: Commanded.EventStore.Adapters.EventStore

    config :eventstore, 
      column_data_type: "jsonb"

    config :eventstore, EventStore.Storage,
      serializer: EventStore.JsonbSerializer,
      types: EventStore.PostgresTypes,
      username: "postgres",
      password: "postgres",
      database: "#{Mix.Project.config[:app]}_estore_#{Mix.env()}",
      hostname: "localhost",
      pool_size: 10,
      pool_overflow: 5
end
