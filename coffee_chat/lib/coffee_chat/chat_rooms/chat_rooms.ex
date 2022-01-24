defmodule CoffeeChat.ChatRooms.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.ChatServers.ChatServer
  alias CoffeeChat.ChatMessages.ChatMessage

  @fields [
    :chat_room_name,
    :chat_room_description,
    :chat_room_type
  ]

  @primary_key {:chat_room_id, :binary_id, autogenerate: true}
  schema "chat_rooms" do
    field(:chat_room_name, :string)
    field(:chat_room_description, :string)
    field(:chat_room_type, :string)
    has_many(:chat_messages, ChatMessage, foreign_key: :chat_room_id)

    belongs_to(:chat_server_id, ChatServer, type: :binary_id, foreign_key: :chat_server_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
