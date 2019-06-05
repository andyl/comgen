defmodule ComspecTest do
  use ExUnit.Case

  describe "#name" do
    test "returns a string" do
      assert [head | _] = ComspecConfig.keys()
      assert comspec = ComspecConfig.struct_data!(head)
      assert Comspec.name(comspec)
    end
  end

  describe "#dirname" do
    test "returns a string" do
      assert [head | _] = ComspecConfig.keys()
      assert comspec = ComspecConfig.struct_data!(head)
      assert Comspec.dirname(comspec)
    end

    test "returns a string (type lib)" do
      assert [head | _] = ComspecConfig.keys()
      assert comspec = ComspecConfig.struct_data!(head)
      assert Comspec.dirname(comspec, "lib") == "tmp/lib/accounts"
    end

    test "returns a string (type test)" do
      assert [head | _] = ComspecConfig.keys()
      assert comspec = ComspecConfig.struct_data!(head)
      assert Comspec.dirname(comspec, "test")
    end
  end

  describe "#basedir" do
    test "gets correct value" do
      assert Comspec.basedir() == "tmp/"
    end
  end
end
