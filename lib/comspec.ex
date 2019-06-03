defmodule Comspec do
  @moduledoc """
  A struct to handle a comspec.
  """

  use TypedStruct

  typedstruct do
    field(:aggregates, list())
    field(:commands, list())
    field(:command_handlers, list())
    field(:command_routers, list())
    field(:command_validators, list())
    field(:events, list())
    field(:event_handlers, list())
    field(:event_projectors, list())
    field(:process_managers, list())
    field(:read_schemas, list())
    field(:read_queries, list())
    field(:spec_name, String.t())
    field(:spec_shortdoc, String.t())
    field(:spec_doc, String.t())
    field(:spec_run_before, list())
    field(:spec_run_after, list())
  end

  @doc """
  Get a list of all defined comspec keys.

  The comspecs are defined in `config/comspecs/*.exs`.
  """
  def keys do
    Application.get_all_env(:comspecs)
    |> Keyword.keys()
    |> Enum.sort()
  end

  @doc """
  A comspec holds a struct with configuration specs for a Commanded context.

  The comspecs are defined in `config/comspecs/*.exs`.
  """
  def data(key) do
    Application.get_env(:comspecs, key)
  end

  @doc """
  Return a table containing the comspec key and shortdoc.

  For use in mix-task help messages.
  """
  def help_table do
    keys()
    |> Enum.map(&([clean(&1), data(&1)[:spec_shortdoc]]))
  end

  defp clean(name) do
    name
    |> to_string
    |> String.replace(~r/Elixir./, "")
  end
end
