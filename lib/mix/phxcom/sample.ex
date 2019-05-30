defmodule Mix.Phxcom.Sample do
  def user_data do
    %{
      context: "User",
      fields: [
        name: "string",
        balance: "float"
      ],
      commands:
    }
  end

  def chat_data doo
    %{
      context: "ChatMsg",
      fields: [
        text: "string",
        user_uuid: "string",
      ]
    }
  end
end
