use Mix.Config

# This comspec is inspired by the series "Event Sourcing with Elixir" by Bruno
# Antunes.  https://blog.nootch.net/post/event-sourcing-with-elixir/

comspec = %{
  Accounts: %{
    aggregate: %{
      BankAccount: %{
        fields: [:account_number, :balance]
      }
    },
    command: %{
      OpenAccount: %{
        fields: [:account_number, :initial_balance],
        key_field: :account_number
      }
    },
    command_handler: ["NoOpMiddleware"],
    command_router: ["BankRouter"],
    event: %{
      BankAccountOpened: [:account_number, :initial_balance]
    },
    event_projector: ["ExampleProjector"],
    read: %{
      fields: ~w(name:string balance:integer)
    },
    saga: %{
      TransferMoneyProcessManager: %{
        fields: [:transfer_uuid, :debit_account, :credit_account, :amount, :status]
      }
    }
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
