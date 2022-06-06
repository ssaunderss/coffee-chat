defmodule CoffeeChat.ChatServer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatServerMembership,
    ChatRoom
  }

  @fields [
    :name,
    :description
  ]

  schema "chat_servers" do
    field(:name, :string)
    field(:description, :string)

    has_many(:chat_server_memberships, ChatServerMembership)
    has_many(:chat_rooms, ChatRoom)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
