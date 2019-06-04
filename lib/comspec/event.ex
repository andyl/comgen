defmodule Comspec.Event do
  @moduledoc """
  A struct to handle an Event.
  """

  use TypedStruct

  typedstruct do
    field(:name, String.t())
    field(:fields, list())
  end

  @doc """
  Build the code and test cases for Events
  """
  def build(comspec) do
    # generate lib and test directories
    ["lib", "test"]
    |> Enum.map(&dirname(comspec, &1))
    |> Enum.each(&Mix.Comgen.gen_dir(&1))

    Enum.each(comspec.events, &build_event(comspec, &1))
  end

  @doc """
  Directory name for event struct.
  """
  def dirname(comspec, type \\ "lib") do
    Comspec.dirname(comspec, type) <> "/events"
  end

  @doc """
  Event name.
  """
  def name(event) do
    event.name 
  end

  defp build_event(comspec, event) do
    context = [comspec: comspec, event: event]
    ev_name = Mix.Comgen.snake(event[:name])

    IO.inspect ev_name

    # write code files
    with src_file <- Comspec.template_dir() <> "/event.ex",
         dest_file <- dirname(comspec, "lib") <> ev_name <> ".ex" do
      IO.puts "============================================================="
      IO.inspect src_file
      IO.inspect dest_file
      Mix.Comgen.gen_file(src_file, dest_file, context)
    end

    # write test files
    # with src_file <- Comspec.template_dir() <> "/event_test.ex",
    #      dest_file <- dirname(comspec, "test") <> ev_name <> ".ex" do
    #   Mix.Comgen.gen_file(src_file, dest_file, context)
    # end
  end

end
