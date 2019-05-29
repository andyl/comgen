use Mix.Config

config :commanded, :genspec, %{
  "User", %{
    fields: [
      name: "string",
      balance: "float"
      ]
  }
}

appname = Mix.Project.config[:app]
mixenv = Mix.env()

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: BankAPI.Repo

config :eventstore, 
  column_data_type: "jsonb"

config :eventstore, EventStore.Storage,
  serializer: EventStore.JsonbSerializer,
  types: EventStore.PostgresTypes,
  username: "postgres",
  password: "postgres",
  database: "#{appname}_estore_#{mixenv}",
  hostname: "localhost",
  pool_size: 10,
  pool_overflow: 5

