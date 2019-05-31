defmodule Mix.Tasks.Phxcom.Add.Config do
  use Mix.Task
  alias Mix.Generator

  @shortdoc "Add Commanded Config"

  @moduledoc """
  Add Commanded Config

  This task adds Commanded configuration settings to your application.

  - Write commanded config to `config/commanded.ex`.
  - Add a line `import_config("commanded.exs")` to your `config/config.exs` file.

  ## Examples

      mix phxcom.add.config


  """

  @doc false
  def run(_) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix phx.gen.config can only run in an app directory")
    end

    write_config_file("commanded")
    write_config_file("comspec")
    add_import_line()
  end

  defp write_config_file(file) do
    text =
      :code.priv_dir(:phoenix_commanded)
      |> (&"#{&1}/templates/phxcom.add.config/#{file}.exs").()
      |> File.read()
      |> elem(1)
      |> EEx.eval_string([])

    Generator.create_file("config/#{file}.exs", text)
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
