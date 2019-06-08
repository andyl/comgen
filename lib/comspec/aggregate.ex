defmodule Comspec.Aggregate do
  @moduledoc """
  A struct to handle an Aggregate and generate Aggregate Resources.
  """

  @dirtype "aggregates"
  @modtype "Aggregates"

  use TypedStruct
  import ComspecUtil

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
    field(:commands, list())
    field(:events, list())
  end

  @doc """
  Build the directories, code and test cases for Aggregates
  """
  def build_aggregates(comspec) do
    comspec
    |> aggregate_directories()
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    %ComspecToken{comspec: comspec}
    |> aggregate_filedata()
    |> aggregate_annotations()
    |> generate_aggregate_files()
  end

  @doc """
  Return a list of generated directories for the aggregate.
  """
  def aggregate_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1, @dirtype))
  end

  @doc """
  Add filedata to ComspecToken
  """
  def aggregate_filedata(%ComspecToken{} = token) do
    name = token.comspec |> Comspec.name() |> Mix.Comgen.snake()

    data =
      token.comspec.aggregates
      |> Enum.map(&Map.put(&1, :templates, template_paths(token.comspec, &1)))
      |> Enum.map(&Map.put(&1, :snake_name, name))
      |> Enum.map(&Map.put(&1, :module_long, module_long(token.comspec, &1, @modtype)))
      |> Enum.map(&Map.put(&1, :module_short, module_short(&1)))
      |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))
      |> Enum.map(&Map.put(&1, :api, &1.api))

    %ComspecToken{token | filedata: data}
  end

  def aggregate_filedata(%{} = comspec) do
    aggregate_filedata(%ComspecToken{comspec: comspec})
  end

  @doc """
  Add annotation data to the ComspecToken:
  - list of all Command modules
  - list of all Event modules
  """
  def aggregate_annotations(%ComspecToken{} = token) do
    event_data =
      token.comspec.events
      |> Enum.map(&Map.put(&1, :module_long, module_long(token.comspec, &1, "Events")))

    command_data =
      token.comspec.commands
      |> Enum.map(&Map.put(&1, :module_long, module_long(token.comspec, &1, "Commands")))

    annotation_data = %{
      events: event_data,
      commands: command_data
    }

    %ComspecToken{token | annotations: annotation_data}
  end

  def aggregate_annotations(%{} = comspec) do
    aggregate_annotations(%ComspecToken{comspec: comspec})
  end

  # --------------------------------------------------------- 

  defp generate_aggregate_files(%ComspecToken{} = token) do
    token.filedata
    |> Enum.each(&generate_aggregate_files(token.comspec, &1, token.annotations))
  end

  defp generate_aggregate_files(comspec, aggregate, annotations) do
    generate_files(comspec, aggregate, annotations)
  end

  defp template_paths(comspec, aggregate) do
    ev_name = Mix.Comgen.snake(aggregate[:name])

    %{
      lib: %{
        src: Comspec.template_dir() <> "aggregate.ex",
        dst: dirname(comspec, "lib", @dirtype) <> "/" <> ev_name <> ".ex"
      },
      test: %{
        src: Comspec.template_dir() <> "aggregate_test.exs",
        dst: dirname(comspec, "test", @dirtype) <> "/" <> ev_name <> "_test.exs"
      }
    }
  end
end
