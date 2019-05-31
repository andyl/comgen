defmodule Mix.Phxcom do
  @moduledoc """
  Helper Utilities for File generators 
  """

  def app do
    Mix.Project.config()[:app]
  end

  def env do
    Mix.env()
  end

  def read_store do
    Application.get_env(app(), :ecto_repos)
    |> List.first()
  end

  def taskname do
    __MODULE__
    |> Mix.Task.task_name()
  end

  def oscmd(arg) do
    String.to_atom(arg)
    |> :os.cmd()
  end

  @doc """
  The comspec is defined in `config/commanded.exs`.

  The comspec holds a map with a separate key for each context.
  """
  def comspec do
    Application.get_env(:commanded, :comspec)
  end

  def contexts do
    Map.keys(comspec())
    |> Enum.map(&(Atom.to_string(&1)))
  end

  def snake(string) do
    Macro.underscore(string)
  end

  def priv_dir do
    "priv"
  end

  def ctx_dir(ctx_name, subdir, type \\ "lib") do
    dc_name = String.downcase(ctx_name)
    "#{type}/#{app()}/#{dc_name}/#{subdir}"
  end

  def valid_types do
    [
      :integer,
      :float,
      :decimal,
      :boolean,
      :map,
      :string,
      :array,
      :references,
      :text,
      :date,
      :time,
      :time_usec,
      :naive_datetime,
      :naive_datetime_usec,
      :utc_datetime,
      :utc_datetime_usec,
      :uuid,
      :binary
    ]
  end
end
