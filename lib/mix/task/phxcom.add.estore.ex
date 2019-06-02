defmodule Mix.Tasks.Phxcom.Add.Estore do
  use Mix.Task

  @shortdoc "Add Commanded Event Store"

  @moduledoc """
  Add Commanded Event Store

  Runs mix tasks:

      mix compile
      MIX_ENV=test mix compile
      mix event_store.create
      mix event_store.init
      MIX_ENV=test mix event_store.create
      MIX_ENV=test mix event_store.init

  """

  @doc false
  def run(_) do
    IO.puts "----- Compile DEV (this might take awhile...)\n"
    IO.puts Mix.Phxcom.shellcmd("mix compile")
    IO.puts "----- Compile TEST (this might take awhile...)\n"
    IO.puts Mix.Phxcom.shellcmd("MIX_ENV=test mix compile")
    IO.puts "----- Estore for DEV\n"
    IO.puts Mix.Phxcom.shellcmd("mix event_store.create")
    IO.puts Mix.Phxcom.shellcmd("mix event_store.init")
    IO.puts "----- Estore for TEST\n"
    IO.puts Mix.Phxcom.shellcmd("MIX_ENV=test mix event_store.create")
    IO.puts Mix.Phxcom.shellcmd("MIX_ENV=test mix event_store.init")
  end
end
