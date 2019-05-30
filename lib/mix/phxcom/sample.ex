defmodule Mix.Phxcom.Sample do
  def user_data do
    %{
      context: "User",
      fields: [
        name: "string",
        balance: "float"
      ]
    }
  end

  def chat_data do
    %{
      context: "ChatMsg",
      fields: [
        text: "string",
        user_uuid: "string",
      ]
    }
  end
end
