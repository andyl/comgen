defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event and generate Event Resources.
  """

  @dirtype "events"

  use TypedStruct
  import ComspecUtil

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
  end

  @doc """
  Build the directories, code and test cases for Events
  """
  def build_events(comspec) do
    event_directories(comspec)
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    event_annotations(comspec)
    |> Enum.each(&generate_event_files(comspec, &1))
  end

  @doc """
  Return a list of generated directories for the event.
  """
  def event_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1, @dirtype))
  end

  @doc """
  Add path data for template input/output files to each event.
  """
  def event_annotations(comspec) do
    comspec.events
    |> Enum.map(&Map.put(&1, :templates, template_paths(comspec, &1)))
    |> Enum.map(&Map.put(&1, :snake_name, Mix.Comgen.snake(&1.name)))
    |> Enum.map(&Map.put(&1, :module_long, module_long(comspec, &1)))
    |> Enum.map(&Map.put(&1, :module_short, module_short(&1)))
    |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))
  end

  # --------------------------------------------------------- 
  
  defp generate_event_files(comspec, event) do
    generate_submodule_files(comspec, event)
  end

  defp template_paths(comspec, event) do
    ev_name = Mix.Comgen.snake(event[:name])
    %{
      lib: %{
        src: Comspec.template_dir() <> "event.ex",
        dst: dirname(comspec, "lib", @dirtype) <> "/" <> ev_name <> ".ex"
      },
      test: %{
        src: Comspec.template_dir() <> "event_test.exs",
        dst: dirname(comspec, "test", @dirtype) <> "/" <> ev_name <> "_test.exs"
      }
    }
  end
end
