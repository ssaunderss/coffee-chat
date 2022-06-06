defmodule CoffeeChat.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatServer,
    ChatMessage
  }

  @fields [
    :name,
    :description,
    :type
  ]

  schema "chat_rooms" do
    field(:name, :string)
    field(:description, :string)
    field(:type, :string)

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
