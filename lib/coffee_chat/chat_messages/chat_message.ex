defmodule CoffeeChat.ChatMessage do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatRoom,
    User
  }

  @fields [
    :text,
    :type,
    :sent_at
  ]

  schema "chat_messages" do
    field(:text, :string)
    field(:type, :string)
    field(:sent_at, :utc_datetime)

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
