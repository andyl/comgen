ExUnit.start()

defmodule TestHelper do
  @doc """
  Use this function to reset the base_dir before running tests that generate
  files.  Note that when MIX_ENV == test, basedir == "tmp/test/"
  """
  def reset_base_dir(_args) do
    basedir = Comspec.basedir()
    case [basedir, Mix.env()] do
      ["tmp/", :test] ->
        File.rm_rf!(basedir)
        File.mkdir_p(basedir)
    end
  end
end
