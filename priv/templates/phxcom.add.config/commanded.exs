use Mix.Config

app = Mix.Project.config()[:app]
env = Mix.env()

config :commanded,
  comspec: %{
    User: %{
      fields: [
        name: "string",
        balance: "float"
      ]
    },
    ChatMsg: %{
      fields: [
        user: "string",
        text: "string"
      ]
    }
  }

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: <%= Mix.Phxcom.read_store() %>

config :eventstore,
  column_data_type: "jsonb"

config :eventstore, EventStore.Storage,
  serializer: EventStore.JsonbSerializer,
  types: EventStore.PostgresTypes,
  username: "postgres",
  password: "postgres",
  database: "#{app}_estore_#{env}",
  hostname: "localhost",
  pool_size: 10,
  pool_overflow: 5
