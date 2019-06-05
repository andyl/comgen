defmodule Mix.ComgenTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "#app" do
    test "returns a string" do
      assert Mix.Comgen.app()
    end
  end

  describe "#env" do
    test "returns a string" do
      assert Mix.Comgen.env()
    end
  end

  describe "#read_store" do
    test "returns nil (no read-store configured)" do
      refute Mix.Comgen.read_store()
    end
  end

  describe "#help_table" do
    test "returns a string" do
      assert Mix.Comgen.help_table()
    end
  end

  describe "#snake" do
    test "returns a string" do
      assert Mix.Comgen.snake("MyString") == "my_string"
    end
  end

  describe "#gen_dir" do
    test "generate a basic directory" do
      dirpath = "tmp/test/asdf"
      refute File.dir?(dirpath)
      stdout = capture_io(fn -> Mix.Comgen.gen_dir(dirpath) end)
      assert String.contains?(stdout, "creating")
      assert File.dir?(dirpath)
    end
  end
end
