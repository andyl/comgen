defmodule Comspec.Aggregate do
  @moduledoc """
  A struct to handle a comspec.
  """

  use TypedStruct

  typedstruct do
    field(:name, list())
  end
end
