defmodule Comspec.AggregateTest do
  use ExUnit.Case
  import TestHelper
  import ExUnit.CaptureIO

  setup do
    [comspec_name | _] = ComspecConfig.keys()
    [comspec: ComspecConfig.struct_data!(comspec_name)]
  end

  describe "#aggregate_directories" do
    test "generates correct paths", ctx do
      [lib_dir, test_dir] = Comspec.Aggregate.aggregate_directories(ctx[:comspec])
      assert String.contains?(lib_dir, "lib/comgen/accounts/aggregates")
      assert String.contains?(test_dir, "test/comgen/accounts/aggregates")
    end
  end

  describe "#aggregate_filedata" do
    test "runs w/o exception", ctx do
      assert [_ | _] = Comspec.Aggregate.aggregate_filedata(ctx[:comspec]).filedata
    end

    test "contains aggregate elements", ctx do
      [head | _] = Comspec.Aggregate.aggregate_filedata(ctx[:comspec]).filedata
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

  describe "#build_aggregates" do
    setup [:reset_base_dir]

    test "basic operation", ctx do
      stdout = capture_io(fn -> Comspec.Aggregate.build_aggregates(ctx[:comspec]) end)
      assert stdout
    end

    test "directory generation", ctx do
      [lib_dir, test_dir] = Comspec.Aggregate.aggregate_directories(ctx[:comspec])
      refute File.dir?(lib_dir)
      refute File.dir?(test_dir)
      run = fn -> Comspec.Aggregate.build_aggregates(ctx[:comspec]) end
      capture_io(run)
      assert File.dir?(lib_dir)
      assert File.dir?(test_dir)
    end

    test "file creation", ctx do
      [aggregate | _] = Comspec.Aggregate.aggregate_filedata(ctx[:comspec]).filedata
      paths = aggregate.templates

      refute File.exists?(paths.lib.dst)
      refute File.exists?(paths.test.dst)
      run = fn -> Comspec.Aggregate.build_aggregates(ctx[:comspec]) end
      capture_io(run)
      assert File.exists?(paths.lib.dst)
      assert File.exists?(paths.test.dst)
    end
  end
end
