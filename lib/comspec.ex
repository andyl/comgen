defmodule Comspec do
  @moduledoc """
  A struct to handle a comspec.
  """

  use TypedStruct

  typedstruct do
    # meta-data
    field(:spec_key, String.t())
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

  # -------------------------------------------------------------------
  
  @doc """
  Return the 'name' for a comspec.

  The name is the 'resource name'.  (like "Accounts" or "Users")

  The default value for name is the key that is used to identify the resource.
  If a :spec_name is also defined, that will become the name.

  Sometimes it will be handy to create a series of comspecs, where each comspec
  layers incremental capability to a resource.  In this case, use a series of
  unique comspec keys (like 'Accounts1', 'Accounts2', etc.), each which use the
  same :spec_name (like 'Accounts').
  """
  def name(comspec) do
    comspec.spec_name || comspec.spec_key
  end

  @doc """
  Returns the directory name for a comspec.
  """
  def dirname(comspec, type \\ "lib") do
    resource_dir = name(comspec) |> Mix.Comgen.snake()
    "#{type}/#{resource_dir}"
  end

  @doc """
  Generates a file from a template.
  """
  def gen_file(comspec, src_file, dest_file) do
    text =
      src_file
      |> File.read()
      |> elem(1)
      |> EEx.eval_string([])

    Mix.Generator.create_file(dest_file, text)
  end
end
