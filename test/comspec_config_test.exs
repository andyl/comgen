defmodule ComspecConfigTest do
  use ExUnit.Case

  test "greets the world" do
    assert Comspec.hello() == "world"
  end

  describe "#keys" do
    test "returns a list value" do
      assert [head | tail] = ComspecConfig.keys()
      assert tail == []
    end
  end

  describe "#valid_key?" do
    test "with a valid key" do
      assert [head | _] = ComspecConfig.keys()
      assert ComspecConfig.valid_key?(head)
    end

    test "with a valid string key" do
      assert [head | _] = ComspecConfig.keys()
      assert ComspecConfig.valid_key?(to_string(head))
    end

    test "with an invalid key" do
      refute ComspecConfig.valid_key?("Unknown")
    end
  end

  describe "#kw_data" do
    test "returns data" do
      assert [head | _] = ComspecConfig.keys()
      assert ComspecConfig.kw_data(head)
    end
  end

  describe "#struct_data!" do
    test "returns data" do
      assert [head | _] = ComspecConfig.keys()
      assert ComspecConfig.struct_data!(head)
    end
  end
end
