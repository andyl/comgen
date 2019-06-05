defmodule Mix.Comgen do
  @moduledoc """
  This module has helper utilities for use within mix tasks.
  """

  @doc """
  The project name.
  """
  def app do
    Mix.Project.config()[:app]
  end

  @doc """
  The project module.
  """
  def app_module do
    app()
    |> to_string()
    |> Macro.camelize()
  end

  @doc """
  The Mix environment - :dev, :test or :prod
  """
  def env do
    Mix.env()
  end

  @doc """
  The name of the read store - the Ecto repo.
  """
  def read_store do
    list = Application.get_env(app(), :ecto_repos)

    case list do
      nil -> nil
      _ -> List.first(list)
    end
  end

  @doc """
  Generate help_table text.
  """
  def help_table do
    render_opts = [
      horizontal_style: :off,
      vertical_style: :all,
      vertical_symbol: "#"
    ]

    TableRex.Table.new(ComspecConfig.help_table_data())
    |> TableRex.Table.render!(render_opts)
    |> String.replace(~r/^# /, "")
    |> String.replace(~r/ #$/, "")
    |> String.replace(~r/#\n# /, "\n")
  end

  @doc """
  Convert string to snake-case.
  """
  def snake(string) do
    Macro.underscore(string)
  end

  @doc false
  def priv_dir do
    "priv"
  end

  @doc false
  def ctx_dir(ctx_name, subdir, type \\ "lib") do
    dc_name = String.downcase(ctx_name)
    "#{type}/#{app()}/#{dc_name}/#{subdir}"
  end

  @doc """
  Run a shell command and stream results to stdout.
  """
  def shellcmd(cmd, env \\ []) do
    [base_cmd | args] = String.split(cmd)

    System.cmd(base_cmd, args,
      env: env,
      parallelism: false,
      into: IO.stream(:stdio, :line)
    )
  end

  @doc """
  Generate a directory, unless it already exists.
  """
  def gen_dir(path) do
    unless File.dir?(path) do
      path
      |> Mix.Generator.create_directory()
    end
  end

  @doc """
  Generates a file from a template.
  """
  def gen_file(src_file, dest_file, ctx \\ []) do
    text =
      src_file
      |> File.read()
      |> elem(1)
      |> EEx.eval_string(ctx)

    Mix.Generator.create_file(dest_file, text)
  end

  @doc false
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
