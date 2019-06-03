defmodule Mix.Tasks.Comgen.Build do
  @shortdoc "Generate Commanded Code from the `comspec`"

  @moduledoc """
  Generates Commanded code from the `comspec`

      mix comgen.build [<COMSPEC>]

  The `comspec` are defined in `config/comspecs/*.exs`.

  If you don't specify a comspec, a list of valid comspecs will be printed.

  """

  use Mix.Task

  @doc false
  def run(args) do
    case args do
      [] -> IO.puts(usage_msg())
      [name | opts] -> process(name, opts, is_valid(name))
    end
  end

  defp usage_msg do
    htext = ["COMSPEC", "DESCRIPTION"]
    ttext = TableRex.quick_render!(Comspec.help_table(), htext)
    """
    Usage: mix comgen.build <COMSPEC>
    #{ttext}  show comspec definition with `mix comspect.show <COMSPEC>`
      find comspec source at `config/comspecs/*.exs`
    """
  end

  defp process(name, _, valid_name?) when valid_name? == false do
    """
    Error: unrecognized comspec name (#{name})
    #{usage_msg()}
    """
    |> IO.puts()
  end

  defp process(name, _, _) do
    Comgen.run(name)
  end

  defp is_valid(name) do
    Comspec.keys()
    |> Enum.any?(&(&1 == name))
  end
end
