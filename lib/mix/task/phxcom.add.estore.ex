defmodule Mix.Tasks.Phxcom.Add.Estore do
  use Mix.Task

  @shortdoc "Add Commanded Event Store"

  @moduledoc """
  Add Commanded Event Store

  Runs two mix tasks:

      mix run event_store.create
      mix run event_store.init


  """

  @doc false
  def run(_) do
    Mix.Tasks.EventStore.Create.run([])
    Mix.Tasks.EventStore.Init.run([])
  end
end
