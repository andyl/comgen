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
    aggregate_directories(comspec)
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    aggregate_annotations(comspec)
    |> Enum.each(&generate_aggregate_files(comspec, &1))
  end

  @doc """
  Return a list of generated directories for the aggregate.
  """
  def aggregate_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1, @dirtype))
  end

  @doc """
  Add path data for template input/output files to each aggregate.
  """
  def aggregate_annotations(comspec) do
    comspec.aggregates
    |> Enum.map(&Map.put(&1, :templates, template_paths(comspec, &1)))
    |> Enum.map(&Map.put(&1, :snake_name, Mix.Comgen.snake(&1.name)))
    |> Enum.map(&Map.put(&1, :module_long, module_long(comspec, &1, @modtype)))
    |> Enum.map(&Map.put(&1, :module_short, module_short(&1)))
    |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))
    |> (&(%{aggregates: &1})).()
  end

  # --------------------------------------------------------- 

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

  defp generate_aggregate_files(comspec, annotation) do
    generate_files(comspec, annotation)
  end
end
