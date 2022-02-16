defmodule CoffeeChat.ChatServers.ChatServer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.ChatServerMemberships.ChatServerMembership
  alias CoffeeChat.ChatRooms.ChatRoom

  @fields [
    :chat_server_name,
    :chat_server_description,
  ]

  @primary_key {:chat_server_id, :binary_id, autogenerate: true}
  schema "chat_servers" do
    field(:chat_server_name, :string)
    field(:chat_server_description, :string)
    has_many(:chat_server_memberships, ChatServerMembership)
    has_many(:chat_rooms, ChatRoom, foreign_key: :chat_room_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
