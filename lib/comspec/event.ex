defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event and generate Event Resources.
  """

  use TypedStruct

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

    event_filepaths(comspec)
    |> Enum.each(&generate_event_files(comspec, &1))
  end

  @doc """
  Return a list of generated directories for the event.
  """
  def event_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1))
  end

  @doc """
  Add path data for template input/output files to each event.
  """
  def event_filepaths(comspec) do
    comspec.events
    |> Enum.map(&Map.put(&1, :templates, template_paths(comspec, &1)))
    |> Enum.map(&Map.put(&1, :snake_name, Mix.Comgen.snake(&1.name)))
    |> Enum.map(&Map.put(&1, :module_name, module_name(comspec, &1)))
    |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))
  end

  # --------------------------------------------------------- 

  defp name(comspec) do
    comspec.spec_name || comspec.spec_key
  end

  defp dirname(comspec, type) do
    Comspec.dirname(comspec, type) <> "/events"
  end

  defp string_fields(event) do
    event.fields
    |> Enum.map(&":#{to_string(&1)}")
    |> Enum.join(", ")
  end

  defp module_name(comspec, event) do
    "#{Mix.Comgen.app_module()}.#{name(comspec)}.Events.#{event.name}"
  end

  defp template_paths(comspec, event) do
    %{
      lib: %{
        src: path_for(comspec, event, {:lib, :src}),
        dest: path_for(comspec, event, {:lib, :dest})
      },
      test: %{
        src: path_for(comspec, event, {:test, :src}),
        dest: path_for(comspec, event, {:test, :dest})
      }
    }
  end

  defp path_for(comspec, event, type) do
    ev_name = Mix.Comgen.snake(event[:name])

    case type do
      {:lib, :src} -> Comspec.template_dir() <> "event.ex"
      {:lib, :dest} -> dirname(comspec, "lib") <> "/" <> ev_name <> ".ex"
      {:test, :src} -> Comspec.template_dir() <> "event_test.exs"
      {:test, :dest} -> dirname(comspec, "test") <> "/" <> ev_name <> "_test.exs"
    end
  end

  defp generate_event_files(comspec, event) do
    context = [comspec: comspec, event: event]
    paths = event[:templates]

    Mix.Comgen.gen_file(paths.lib.src, paths.lib.dest, context)
    Mix.Comgen.gen_file(paths.test.src, paths.test.dest, context)
  end
end
