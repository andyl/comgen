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
      [name | opts] -> process(name, opts, is_valid(name))
    end
  end

  defp usage_msg do
    htext = ["COMSPEC", "DESCRIPTION"]
    ttext = TableRex.quick_render!(Comspec.help_table(), htext)
    """
    Usage: mix comgen.show <COMSPEC>
    #{ttext}  find comspec source at `config/comspecs/*.exs`
    """
  end

  defp process(name, _, valid_name) when not valid_name do
    """
    Error: unrecognized comspec name (#{name})
    #{usage_msg()}
    """
    |> IO.puts()
  end

  defp process(name, _, _) do
    Comspec.data(name)
    |> IO.inspect()
  end

  defp is_valid(name) do
    Comspec.keys()
    |> Enum.any?(&(&1 == name))
  end
end
