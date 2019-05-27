defmodule Mix.Phxcom do
  def app_name do
    Mix.Project.config[:app]
  end

  def env do
    Mix.env()
  end

  def taskname do
    __MODULE__
    |> Mix.Task.task_name()
  end

  def lib_dir do
    app_name()
    |> (&("lib/#{&1}")).()
  end

  def priv_dir do
    "priv"
  end

  def ctx_dir(name, type) do
    dname = String.downcase(name)
    "#{lib_dir()}/#{dname}/#{type}"
  end
end
