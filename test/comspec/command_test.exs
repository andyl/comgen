defmodule Comspec.CommandTest do
  use ExUnit.Case
  import TestHelper
  import ExUnit.CaptureIO

  setup do
    [comspec_name | _] = ComspecConfig.keys()
    [comspec: ComspecConfig.struct_data!(comspec_name)]
  end

  describe "#command_directories" do
    test "generates correct paths", ctx do
      [lib_dir, test_dir] = Comspec.Command.command_directories(ctx[:comspec])
      assert String.contains?(lib_dir, "lib/comgen/accounts/commands")
      assert String.contains?(test_dir, "test/comgen/accounts/commands")
    end
  end

  describe "#command_annotations" do
    test "runs w/o exception", ctx do
      assert [_ | _] = Comspec.Command.command_annotations(ctx[:comspec])
    end

    test "contains command elements", ctx do
      [head | _] = Comspec.Command.command_annotations(ctx[:comspec])
      assert head[:name]
      assert head[:fields]
      assert head[:templates]
      assert head[:templates][:lib]
      assert head[:templates][:lib][:src]
      assert head[:templates][:lib][:dst]
      assert head[:templates][:test]
      assert head[:templates][:test][:src]
      assert head[:templates][:test][:dst]
    end
  end

  describe "#build_commands" do
    setup [:reset_base_dir]

    test "basic operation", ctx do
      stdout = capture_io(fn -> Comspec.Command.build_commands(ctx[:comspec]) end)
      assert stdout
    end

    test "directory generation", ctx do
      [lib_dir, test_dir] = Comspec.Command.command_directories(ctx[:comspec]) 
      refute File.dir?(lib_dir)
      refute File.dir?(test_dir)
      capture_io(fn -> Comspec.Command.build_commands(ctx[:comspec]) end)
      assert File.dir?(lib_dir)
      assert File.dir?(test_dir)
    end

    test "file creation", ctx do
      [command|_] = Comspec.Command.command_annotations(ctx[:comspec])
      paths = command.templates

      refute File.exists?(paths.lib.dst)
      refute File.exists?(paths.test.dst)
      run = fn -> Comspec.Command.build_commands(ctx[:comspec]) end
      # run.()
      capture_io(run)
      assert File.exists?(paths.lib.dst)
      assert File.exists?(paths.test.dst)
    end
  end
end
