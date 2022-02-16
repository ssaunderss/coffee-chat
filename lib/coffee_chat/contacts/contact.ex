defmodule CoffeeChat.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.Users.User

  @fields [
    :contact_id
  ]

  @primary_key false
  schema "contacts" do
    field(:contact_id, :binary_id)

    belongs_to(:user_id, User, type: :binary_id, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
