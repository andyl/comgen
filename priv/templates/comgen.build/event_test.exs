# <%= filedata.templates.test.dst%>
defmodule <%= filedata.module_long %>Test do
  use ExUnit.Case
  alias <%= filedata.module_long %>

  describe "<%= filedata.module_short %> struct" do
    test "creates an empty struct" do
      assert %<%= filedata.module_short %>{}
    end
  end
end
