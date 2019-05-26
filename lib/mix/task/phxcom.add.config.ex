defmodule Mix.Tasks.Phxcom.Add.Config do
  use Mix.Task

  @shortdoc "Add Commanded Config"

  @moduledoc """
  Add Commanded Config

  ## Examples
  
      mix phxcom.add.config

  ## Actions

  - Write commanded config to `config/commanded.ex`.
  - Add a line `import_config("commanded.exs")` to `config/config.exs`

  Re-running this command will over-write any changes you make to your
  `config/commended.ex` file.

  """

  @doc false
  def run(_) do
    IO.puts "INIT - Implementation TBD"
  end
end
