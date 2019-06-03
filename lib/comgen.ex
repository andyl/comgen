defmodule Comgen do
  @moduledoc """
  Commanded generator
  """

  @doc """
  Run the code generator.
  """
  def run(comspec \\ %Comspec{}) do
    IO.inspect(comspec)
  end
end
