defmodule CoffeeChat.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    Contacts.Contact,
    ChatServerMemberships.ChatServerMembership
  }

  @fields [
    :username,
    :password,
    :email,
    :status
  ]

  schema "users" do
    field(:username, :string)
    field(:password, :string, redact: true)
    field(:email, :string)
    field(:status, :string)

    has_many(:chat_server_memberships, ChatServerMembership)

    has_many(:contacts, Contact)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
