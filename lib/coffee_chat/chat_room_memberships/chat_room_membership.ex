defmodule CoffeeChat.ChatRoomMembership do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    User,
    ChatRoom,
    Role
  }

  @fields [
    :membership_status,
    :join_timestamp
  ]

  schema "chat_room_memberships" do
    field(:membership_status, :string)
    field(:join_timestamp, :utc_datetime)

    belongs_to(:user, User)
    belongs_to(:chat_room, ChatRoom)

    has_one(:role, Role)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
