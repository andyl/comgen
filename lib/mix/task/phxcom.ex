defmodule Mix.Tasks.Phxcom do
  use Mix.Task

  @shortdoc "Prints Phxcom help information"

  @moduledoc """
  Prints Phxcom tasks and their information

      mix phxcom
  

  """

  @doc false
  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Invalid arguments, expected: mix phx"
    end
  end

  defp general() do
    Mix.shell.info "Phxcom - code generators for Phoenix/Commanded"
    Mix.shell.info "\nAvailable tasks:\n"
    Mix.Tasks.Help.run(["--search", "phxcom."])
  end
end
