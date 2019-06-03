defmodule Mix.Tasks.Comgen do
  use Mix.Task

  @shortdoc "Prints Comgen help information"

  @moduledoc """
  Prints Comgen tasks and their information

      mix comgen
  

  """

  @doc false
  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Invalid arguments, expected: mix comgen"
    end
  end

  defp general() do
    Mix.shell.info "Comgen - code generators for Commanded"
    Mix.shell.info "\nAvailable tasks:\n"
    Mix.Tasks.Help.run(["--search", "comgen."])
  end
end
