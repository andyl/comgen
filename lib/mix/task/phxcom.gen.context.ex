defmodule Mix.Tasks.Phxcom.Gen.Context do
  @shortdoc "Generate Commanded Context"

  @moduledoc """
  Generates a Commanded context

      mix phxcom.gen.context Account name:string balance:integer

  The first argument is the context module name.  Following that, there are a
  list of fields and field-types supported by the context.
  """

  use Mix.Task

  @doc false
  def run(args) do
    case args do
      [_] -> usage()
      [name | fields] -> gen_ctx(name, fields)
      _ -> usage()
    end
  end

  # -----

  defp usage do
    tname = Mix.Task.task_name(__MODULE__)

    """
    USAGE: mix #{tname} <Context> <fields>"
      fields are in the form <name>:<type>"
      eg. `mix #{tname} Account name:string balance:integer`
    """
    |> Mix.Shell.IO.info()
  end

  # -----

  defp gen_ctx(name, fields) do
    with :ok <- validate_args(name, fields),
         :ok <- gen_dirs(name),
         :ok <- gen_files(fields) do
      Mix.Shell.IO.info("ok")
    end
  end

  # -----

  defp validate_args(_name, _fields) do
    :ok
  end

  # -----

  defp dir_list do
    ~w(aggregate 
       command 
       command/handler command/middleware command/router command/validator 
       event 
       event/handler event/projector 
       read/schema read/query
       saga)
  end

  defp gen_dirs(name) do
    dir_list()
    |> Enum.each(fn subdir -> gen_dir(name, subdir, "lib") end)

    dir_list()
    |> Enum.each(fn subdir -> gen_dir(name, subdir, "test") end)

    :ok
  end

  defp gen_dir(name, subdir, type) do
    Mix.Phxcom.ctx_dir(name, subdir, type)
    |> Mix.Generator.create_directory()
  end

  # -----

  defp gen_files(fields) do
    Mix.Shell.IO.info("GenFields (UNDER CONSTRUCTION)")
    IO.inspect(fields)
    :ok
  end
end
