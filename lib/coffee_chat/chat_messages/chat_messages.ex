defmodule CoffeeChat.ChatMessages.ChatMessage do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.ChatRooms.ChatRoom
  alias CoffeeChat.Users.User

  @fields [
    :chat_text,
    :room_type,
    :sent_timestamp
  ]

  @primary_key {:chat_message_id, :binary_id, autogenerate: true}
  schema "chat_messages" do
    field(:chat_text, :string)
    field(:room_type, :string)
    field(:sent_timestamp, :utc_datetime)

    belongs_to(:chat_room_id, ChatRooms, type: :binary_id, foreign_key: :chat_room_id)
    belongs_to(:author_id, User, type: :binary_id, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
