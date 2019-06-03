defmodule PhoenixCommandedTest do
  use ExUnit.Case
  doctest PhoenixCommanded

  test "greets the world" do
    assert PhoenixCommanded.hello() == :world
  end
end
