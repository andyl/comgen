defmodule Mix.Tasks.Phxcom.Gen.Code do
  @shortdoc "Generate Commanded Code from the `genspec`"

  @moduledoc """
  Generates Commanded code from the `genspec`

      mix phxcom.gen.code

  The `genspec` is defined in `config/commanded.exs`.

  """

  use Mix.Task

  @doc false
  def run(_) do
    with :ok <- gen_dirs("temp"),
         :ok <- gen_files(~w(a b c)) do
      Mix.Shell.IO.info("ok")
    end
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
