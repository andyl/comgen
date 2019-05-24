defmodule Mix.Tasks.Yo do
  use Mix.Task

  @shortdoc "Simply says Yo"
  def run(_) do
    IO.puts "YO"
  end
end
