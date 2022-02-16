defmodule CoffeeChat.Repo do
  use Ecto.Repo,
    otp_app: :coffee_chat,
    adapter: Ecto.Adapters.Postgres
end
