defmodule Mix.Tasks.Comgen.Build do
  @shortdoc "Generate Commanded Code from the `comspec`"

  @moduledoc """
  Generates Commanded code from the `comspec`

      mix comgen.build [<COMSPEC>]

  The `comspec` are defined in `config/comspecs/*.exs`.

  If you don't specify a comspec, a list of valid comspecs will be printed.

  """

  use Mix.Task

  @doc false
  def run(args) do
    IO.inspect(args)
    [_name | _opts] = String.split(args)
  end

  # -----

  # defp dir_list do
  #   ~w(aggregate 
  #      command 
  #      command/handler command/middleware command/router command/validator 
  #      event 
  #      event/handler event/projector 
  #      read/schema read/query
  #      saga)
  # end

  # defp gen_all(ctx) do
  #   gen_dirs(ctx)
  #   gen_files(ctx)
  # end

  # defp gen_dirs(ctx) do
  #   name = Mix.Comgen.snake(ctx)
  #
  #   dir_list()
  #   |> Enum.each(fn subdir -> gen_dir(name, subdir, "lib") end)
  #
  #   dir_list()
  #   |> Enum.each(fn subdir -> gen_dir(name, subdir, "test") end)
  # end

  # defp gen_dir(name, subdir, type) do
  #   Mix.Comgen.ctx_dir(name, subdir, type)
  #   |> Mix.Generator.create_directory()
  # end

  # -----

  # defp gen_files(ctx) do
  #   Mix.Shell.IO.info("Genctx (UNDER CONSTRUCTION)")
  #   IO.inspect(ctx)
  # end
end
