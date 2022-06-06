defmodule CoffeeChat.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    ChatServerMembership,
    ChatRoomMembership,
    Permission
  }

  @fields [
    :role_name
  ]

  schema "roles" do
    field(:role_name, :string)

    has_many(:permissions, Permission)

    belongs_to(:chat_server_membership, ChatServerMembership)
    belongs_to(:chat_room_membership, ChatRoomMembership)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
