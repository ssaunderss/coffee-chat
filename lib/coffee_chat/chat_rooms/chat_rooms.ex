defmodule CoffeeChat.ChatRooms.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatServers.ChatServer,
    ChatMessages.ChatMessage
  }

  @fields [
    :chat_room_name,
    :chat_room_description,
    :chat_room_type
  ]

  schema "chat_rooms" do
    field(:chat_room_name, :string)
    field(:chat_room_description, :string)
    field(:chat_room_type, :string)

    belongs_to(:chat_server, ChatServer)

    has_many(:chat_messages, ChatMessage)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
