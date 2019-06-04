defmodule Comspec do
  @moduledoc """
  A struct to handle a comspec.
  """

  use TypedStruct

  typedstruct do
    # meta-data
    field(:spec_name, String.t())
    field(:spec_shortdoc, String.t())
    field(:spec_doc, String.t())
    field(:spec_run_before, list())
    field(:spec_run_after, list())
    # specification
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
  end

  @doc """
  Run the code generator.
  """
  def build(comspec_name) do
    comspec = ComspecConfig.struct_data!(comspec_name)
    Comspec.Event.build(comspec)
  end
  
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
