defmodule Mix.Tasks.Comgen.Add.Config do
  use Mix.Task
  alias Mix.Generator

  @shortdoc "Add Commanded Config"

  @moduledoc """
  Add Commanded Config

  This task adds Commanded configuration settings to your application.

  - Write commanded config to `config/commanded.ex`.
  - Write comspec to `config/comspecs/*.exs`.
  - Add a line `import_config("comspecs/*.exs")` to your `config/config.exs` file.

  ## Examples

      mix comgen.add.config


  """

  @doc false
  def run(_) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix comgen.add.config can only run in an app directory")
    end

    write_config_file("commanded.exs")
    Generator.create_directory("config/comspecs")
    write_comspecs()
    add_import_line()
  end

  defp template_dir do
    :code.priv_dir(:comgen)
    |> (&"#{&1}/templates/comgen.add.config/").()
  end

  defp write_comspecs do
    template_dir() <> "/comspecs"
    |> File.ls()
    |> elem(1)
    |> Enum.filter(&(Regex.match?(~r/.exs/, &1)))
    |> Enum.each(&(write_config_file("comspecs/#{&1}")))
  end

  defp write_config_file(file) do
    text =
      "#{template_dir()}/#{file}"
      |> File.read()
      |> elem(1)
      |> EEx.eval_string([])

    Generator.create_file("config/#{file}", text)
  end

  defp add_import_line do
    import_text = """

    # Import config settings for Commanded
    import_config("commanded.exs")
    """

    cfg_file = "config/config.exs"
    {:ok, text} = File.read(cfg_file)

    unless Regex.match?(~r/commanded.exs/, text) do
      File.open(cfg_file, [:append], fn file ->
        IO.puts(file, import_text)
      end)

      IO.puts("#{IO.ANSI.green()}* updating #{IO.ANSI.white()}config/config.exs")
    end
  end
end
