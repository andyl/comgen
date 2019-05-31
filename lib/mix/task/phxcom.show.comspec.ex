defmodule Mix.Tasks.Phxcom.Show.Comspec do
  use Mix.Task

  @shortdoc "Show the `comspec`"

  @moduledoc """
  TBD
  """

  @doc false
  def run(_) do
    IO.inspect Mix.Phxcom.comspec()
  end
end
