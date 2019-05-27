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

  def priv_dir do
    "priv"
  end

  def ctx_dir(ctx_name, subdir, type \\ "lib") do
    dc_name = String.downcase(ctx_name)
    "#{type}/#{app_name()}/#{dc_name}/#{subdir}"
  end
end
