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

  ## Note

  Re-running this command will over-write any changes you make to your
  `config/commended.ex` file.


  """

  @doc false
  def run(_) do
    if Mix.Project.umbrella? do
      Mix.raise "mix phx.gen.config can only be run inside an application directory"
    end

    write_config_file()
    add_import_line()
  end

  defp write_config_file do
    filename = :code.priv_dir(:phoenix_commanded) <> "/templates/phxcom.add.config/commanded.exs"
    text = File.read(filename)
    Generator.create_file("config/commanded.exs", text)
  end

  defp add_import_line do
    IO.puts "#{IO.ANSI.green()}* updating #{IO.ANSI.white()}config/config.exs"
  end
end
