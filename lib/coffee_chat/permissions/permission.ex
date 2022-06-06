defmodule CoffeeChat.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  alias CoffeeChat.{
    Role
  }

  @fields [
    :permission
  ]

  schema "permissions" do
    field(:permission, :string)

    belongs_to(:role, Role)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
