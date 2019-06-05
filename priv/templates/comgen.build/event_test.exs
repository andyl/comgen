# <%= event.templates.test.dest%>
defmodule <%= event.module_long %>Test do
  use ExUnit.Case
  alias <%= event.module_long %>

  describe "<%= event.module_short %> struct" do
    test "creates an empty struct" do
      assert %<%= event.module_short %>{}
    end
  end
end
