defmodule Comspec.EventTest do
  use ExUnit.Case
  import TestHelper
  import ExUnit.CaptureIO

  setup do
    [comspec_name | _] = ComspecConfig.keys()
    [comspec: ComspecConfig.struct_data!(comspec_name)]
  end

  describe "#dirname" do
    test "generates a lib path", ctx do
      path = Comspec.Event.dirname(ctx[:comspec])
      assert String.contains?(path, "lib/accounts/events")
    end

    test "generates a test path", ctx do
      path = Comspec.Event.dirname(ctx[:comspec], "test")
      assert String.contains?(path, "test/accounts/events")
    end
  end

  describe "#build" do
    setup [:reset_base_dir]

    test "basic operation", ctx do
      stdout = capture_io(fn -> Comspec.Event.build(ctx[:comspec]) end)
      assert stdout
    end

    # test "directory generation", ctx do
    #   refute File.dir?(Comspec.Event.dirname(ctx[:comspec]))
    #   refute File.dir?(Comspec.Event.dirname(ctx[:comspec], "test"))
    #   stdout = capture_io(fn -> Comspec.Event.build(ctx[:comspec]) end)
    #   assert File.dir?(Comspec.Event.dirname(ctx[:comspec]))
    #   assert File.dir?(Comspec.Event.dirname(ctx[:comspec], "test"))
    # end
  end
end
