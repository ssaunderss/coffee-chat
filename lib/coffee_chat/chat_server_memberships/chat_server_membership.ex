defmodule CoffeeChat.ChatServerMembership do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    User,
    ChatServer,
    Role
  }

  @fields [
    :membership_status,
    :join_timestamp
  ]

  schema "chat_server_memberships" do
    field(:membership_status, :string)
    field(:join_timestamp, :utc_datetime)

    belongs_to(:user, User)
    belongs_to(:chat_server, ChatServer)

    has_one(:role, Role)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

  # defp validate_membership_status(%{changes: %{membership_status: membership_status}} = changeset) do
  #   cond do
  #     membership_status in @membership_statuses ->
  #       changeset

  #     true ->
  #       error_message = "Membership status must be a valid role"
  #       add_error(changeset, :membership_status, error_message)
  #   end
  # end
end
