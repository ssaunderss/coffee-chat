defmodule CoffeeChat.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.Contacts.Contact
  alias CoffeeChat.ChatServerMemberships.ChatServerMembership
  alias CoffeeChat.ChatServers.ChatServer

  @fields [
    :username,
    :password,
    :email,
    :status
  ]

  @primary_key {:user_id, :binary_id, autogenerate: true}
  schema "users" do
    field(:username, :string)
    field(:password, :string, redact: true)
    field(:email, :string)
    field(:status, :string)
    has_many :contacts, Contact
    many_to_many :chat_servers, ChatServer,
      join_through: ChatServerMembership,
      join_keys: [{user_id: :user_id, chat_server_id: :chat_server_id}]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
