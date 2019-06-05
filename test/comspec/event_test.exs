defmodule Comspec.EventTest do
  use ExUnit.Case
  import TestHelper
  import ExUnit.CaptureIO

  setup do
    [comspec_name | _] = ComspecConfig.keys()
    [comspec: ComspecConfig.struct_data!(comspec_name)]
  end

  describe "#event_directories" do
    test "generates correct paths", ctx do
      [lib_dir, test_dir] = Comspec.Event.event_directories(ctx[:comspec])
      assert String.contains?(lib_dir, "lib/accounts/events")
      assert String.contains?(test_dir, "test/accounts/events")
    end
  end

  describe "#event_filepaths" do
    test "runs w/o exception", ctx do
      assert [_ | _] = Comspec.Event.event_filepaths(ctx[:comspec])
    end

    test "contains event elements", ctx do
      [head | _] = Comspec.Event.event_filepaths(ctx[:comspec])
      assert head[:name]
      assert head[:fields]
      assert head[:templates]
      assert head[:templates][:lib]
      assert head[:templates][:lib][:src]
      assert head[:templates][:lib][:dest]
      assert head[:templates][:test]
      assert head[:templates][:test][:src]
      assert head[:templates][:test][:dest]
    end
  end

  describe "#build_events" do
    setup [:reset_base_dir]

    test "basic operation", ctx do
      stdout = capture_io(fn -> Comspec.Event.build_events(ctx[:comspec]) end)
      assert stdout
    end

    test "directory generation", ctx do
      [lib_dir, test_dir] = Comspec.Event.event_directories(ctx[:comspec]) 
      refute File.dir?(lib_dir)
      refute File.dir?(test_dir)
      capture_io(fn -> Comspec.Event.build_events(ctx[:comspec]) end)
      assert File.dir?(lib_dir)
      assert File.dir?(test_dir)
    end

    test "file creation", ctx do
      [event|_] = Comspec.Event.event_filepaths(ctx[:comspec])
      paths = event.templates

      refute File.exists?(paths.lib.dest)
      refute File.exists?(paths.test.dest)
      capture_io(fn -> Comspec.Event.build_events(ctx[:comspec]) end)
      assert File.exists?(paths.lib.dest)
      assert File.exists?(paths.test.dest)
    end
  end
end
