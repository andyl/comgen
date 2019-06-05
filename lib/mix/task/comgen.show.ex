defmodule Mix.Tasks.Comgen.Show do
  @shortdoc "Show a comspec"

  @moduledoc """
  Show a comspec

      mix comgen.show [<COMSPEC>]

  The `comspec` are defined in `config/comspecs/*.exs`.

  If you don't specify a comspec, a list of valid comspecs will be printed.

  """

  use Mix.Task

  @doc false
  def run(args) do
    case args do
      [] -> IO.puts(usage_msg())
      [name | opts] -> show(name, opts, ComspecConfig.valid_key?(name))
    end
  end

  defp usage_msg do
    """
    Usage: mix comgen.show <COMSPEC>

    Valid comspecs:

    #{Mix.Comgen.help_table()}
    find comspec source at `config/comspecs/*.exs`
    """
  end

  defp show(name, _, valid_name) when not valid_name do
    """
    Error: unrecognized comspec name (#{name})
    #{usage_msg()}
    """
    |> IO.puts()
  end

  defp show(name, _, _) do
    ComspecConfig.kw_data(name)
    |> IO.inspect()
  end
end
