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
  The Mix environment - :dev, :test or :prod
  """
  def env do
    Mix.env()
  end

  @doc """
  The name of the read store - the Ecto repo.
  """
  def read_store do
    Application.get_env(app(), :ecto_repos)
    |> List.first()
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

    TableRex.Table.new(ComspecConfig.help_table())
    |> TableRex.Table.render!(render_opts)
    |> String.replace(~r/^# /, "")
    |> String.replace(~r/ #$/, "")
    |> String.replace(~r/#\n# /, "\n")
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
