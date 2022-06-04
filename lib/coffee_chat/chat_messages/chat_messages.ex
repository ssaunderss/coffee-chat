defmodule CoffeeChat.ChatMessages.ChatMessage do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatRooms.ChatRoom,
    Users.User
  }

  @fields [
    :chat_text,
    :room_type,
    :sent_timestamp
  ]

  schema "chat_messages" do
    field(:chat_text, :string)
    field(:room_type, :string)
    field(:sent_timestamp, :utc_datetime)

    belongs_to(:chat_room, ChatRoom)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
