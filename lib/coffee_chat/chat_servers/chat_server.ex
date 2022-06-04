defmodule CoffeeChat.ChatServers.ChatServer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatServerMemberships.ChatServerMembership,
    ChatRooms.ChatRoom
  }

  @fields [
    :chat_server_name,
    :chat_server_description
  ]

  schema "chat_servers" do
    field(:chat_server_name, :string)
    field(:chat_server_description, :string)

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
