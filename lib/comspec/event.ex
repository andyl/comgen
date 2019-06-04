defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event.
  """

  use TypedStruct

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
  end

  def build(comspec) do
    Enum.each(comspec.events, &(build_event(comspec, &1)))
  end

  defp build_event(comspec, event) do
    IO.puts "Comspec.Event.build_event --------------------"
    IO.inspect(comspec)
    IO.inspect(event)
    # generate code directories
    # write code files
    # generate test directories
    # write test files
  end
end
