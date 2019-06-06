# <%= submodule.templates.test.dst%>
defmodule <%= submodule.module_long %>Test do
  use ExUnit.Case
  alias <%= submodule.module_long %>

  describe "<%= submodule.module_short %> struct" do
    test "creates an empty struct" do
      assert %<%= submodule.module_short %>{}
    end
  end
end
