defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event and generate Event Resources.
  """

  @dirtype "events"
  @modtype "Events"

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
    comspec
    |> event_directories()
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    %ComspecToken{comspec: comspec}
    |> event_filedata()
    |> generate_event_files()
  end

  @doc """
  Return a list of generated directories for the event.
  """
  def event_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1, @dirtype))
  end

  @doc """
  Add filedata to ComspecToken
  """
  def event_filedata(%ComspecToken{} = token) do
    name = Comspec.name(token.comspec) |> Mix.Comgen.snake()
    data =
      token.comspec.events
      |> Enum.map(&Map.put(&1, :templates, template_paths(token.comspec, &1)))
      |> Enum.map(&Map.put(&1, :snake_name, name))
      |> Enum.map(&Map.put(&1, :module_long, module_long(token.comspec, &1, @modtype)))
      |> Enum.map(&Map.put(&1, :module_short, module_short(&1)))
      |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))

    %ComspecToken{token | filedata: data}
  end

  def event_filedata(%{} = comspec) do
    event_filedata(%ComspecToken{comspec: comspec})
  end

  # --------------------------------------------------------- 

  defp generate_event_files(%ComspecToken{} = token) do
    token.filedata
    |> Enum.each(&generate_event_files(token.comspec, &1))
  end

  defp generate_event_files(comspec, event) do
    generate_files(comspec, event)
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
