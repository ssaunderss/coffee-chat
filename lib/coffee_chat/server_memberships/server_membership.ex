defmodule CoffeeChat.ChatServerMemberships.ChatServerMembership do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.Users.User
  alias CoffeeChat.ChatServers.ChatServer

  @fields [
    :role,
    :membership_status,
    :join_timestamp
  ]

  schema "server_memberships" do
    field(:role, :string)
    field(:membership_status, :string)
    field(:join_timestamp, :utc_datetime)

    belongs_to(:user_id, User, type: :binary_id, foreign_key: :user_id)
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
