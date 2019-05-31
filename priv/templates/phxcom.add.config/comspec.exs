use Mix.Config

# This comspec is inspired by the series "Event Sourcing with Elixir" by Bruno
# Antunes.  https://blog.nootch.net/post/event-sourcing-with-elixir/

comspec = %{
    Accounts: %{
      aggregate: [],
      command: [],
      event: [],
      read: %{
        fields: ~w(name:string balance:integer)
      },
      saga: []
    },
    Users: %{
      aggregate: [],
      command: [],
      event: [],
      read: [],
      saga: []
    }
}

config :commanded, comspec: comspec

