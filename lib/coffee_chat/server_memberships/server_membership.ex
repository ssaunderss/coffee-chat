defmodule CoffeeChat.ChatServerMemberships.ChatServerMembership do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    Users.User,
    ChatServers.ChatServer
  }

  @fields [
    :role,
    :membership_status,
    :join_timestamp
  ]

  @membership_statuses [
    "read",
    "write",
    "user",
    "admin"
  ]

  schema "server_memberships" do
    field(:role, :string)
    field(:membership_status, :string)
    field(:join_timestamp, :utc_datetime)

    belongs_to(:user, User)
    belongs_to(:chat_server, ChatServer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_membership_status()
    |> validate_required(@fields)
  end

  defp validate_membership_status(%{changes: %{membership_status: membership_status}} = changeset) do
    cond do
      membership_status in @membership_statuses ->
        changeset

      true ->
        error_message = "Membership status must be a valid role"
        add_error(changeset, :membership_status, error_message)
    end
  end
end
