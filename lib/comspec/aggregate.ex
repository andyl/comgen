defmodule Comspec.Aggregate do
  @moduledoc """
  A struct to handle an Event
  """

  use TypedStruct

  typedstruct do
    field(:name, list())
  end
end
