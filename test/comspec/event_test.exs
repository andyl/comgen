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
      assert String.contains?(lib_dir, "lib/comgen/accounts/events")
      assert String.contains?(test_dir, "test/comgen/accounts/events")
    end
  end

  describe "#event_filedata" do
    test "runs w/o exception", ctx do
      assert Comspec.Event.event_filedata(ctx[:comspec])
    end

    test "contains event elements", ctx do
      [head | _] = Comspec.Event.event_filedata(ctx[:comspec]).filedata
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
      [event|_] = Comspec.Event.event_filedata(ctx[:comspec]).filedata
      paths = event.templates

      refute File.exists?(paths.lib.dst)
      refute File.exists?(paths.test.dst)
      capture_io(fn -> Comspec.Event.build_events(ctx[:comspec]) end)
      assert File.exists?(paths.lib.dst)
      assert File.exists?(paths.test.dst)
    end
  end
end
