defmodule Mix.Tasks.Phxcom.Show.Genspec do
  use Mix.Task

  @shortdoc "Show the `genspec`"

  @moduledoc """
  TBD
  """

  @doc false
  def run(_) do
    IO.inspect Mix.Phxcom.genspec()
  end
end
