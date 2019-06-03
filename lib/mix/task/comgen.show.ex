defmodule Mix.Tasks.Comgen.Show.Comspec do
  use Mix.Task

  @shortdoc "Show the `comspec`"

  @moduledoc """
  This task simply writes the current `comspec` to stdout.
  """

  @doc false
  def run(_) do
    IO.inspect Comspec.help_table()
  end
end
