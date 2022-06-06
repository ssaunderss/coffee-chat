defmodule CoffeeChat.Contact do
  @moduledoc """
  Acts as a mapping table so we can keep track of all the
  other users an individual user adds as a contact.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.User

  @fields [
    :contact_id
  ]

  schema "contacts" do
    belongs_to(:user, User)

    field(:contact_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
