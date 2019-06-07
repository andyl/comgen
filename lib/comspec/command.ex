defmodule Comspec.Command do
  @moduledoc """
  A struct to handle an Command and generate Command Resources.
  """

  @dirtype "commands"
  @modtype "Commands"

  use TypedStruct
  import ComspecUtil

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
  end

  @doc """
  Build the directories, code and test cases for Commands
  """
  def build_commands(comspec) do
    command_directories(comspec)
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    %ComspecToken{comspec: comspec}
    |> command_filedata()
    |> generate_command_files()
  end

  @doc """
  Return a list of generated directories for the command.
  """
  def command_directories(comspec) do
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1, @dirtype))
  end

  @doc """
  Add filedata to ComspecToken
  """
  def command_filedata(%ComspecToken{} = token) do
    name = Comspec.name(token.comspec) |> Mix.Comgen.snake()

    data =
      token.comspec.commands
      |> Enum.map(&Map.put(&1, :templates, template_paths(token.comspec, &1)))
      |> Enum.map(&Map.put(&1, :snake_name, name))
      |> Enum.map(&Map.put(&1, :module_long, module_long(token.comspec, &1, @modtype)))
      |> Enum.map(&Map.put(&1, :module_short, module_short(&1)))
      |> Enum.map(&Map.put(&1, :string_fields, string_fields(&1)))

    %ComspecToken{token | filedata: data}
  end

  def command_filedata(%{} = comspec) do
    command_filedata(%ComspecToken{comspec: comspec})
  end

  # --------------------------------------------------------- 

  defp generate_command_files(%ComspecToken{} = token) do
    token.filedata
    |> Enum.each(&generate_command_files(token.comspec, &1))
  end

  defp generate_command_files(comspec, command) do
    generate_files(comspec, command)
  end

  defp template_paths(comspec, command) do
    ev_name = Mix.Comgen.snake(command[:name])

    %{
      lib: %{
        src: Comspec.template_dir() <> "command.ex",
        dst: dirname(comspec, "lib", @dirtype) <> "/" <> ev_name <> ".ex"
      },
      test: %{
        src: Comspec.template_dir() <> "command_test.exs",
        dst: dirname(comspec, "test", @dirtype) <> "/" <> ev_name <> "_test.exs"
      }
    }
  end
end
