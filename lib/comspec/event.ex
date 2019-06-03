defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event.
  """

  use TypedStruct

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
  end
end
