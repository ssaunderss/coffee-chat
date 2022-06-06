defmodule CoffeeChat.Repo.Migrations.InitialTableSetup do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 32
      add :password, :string, size: 128
      add :email, :string, size: 256
      add :status, :string, size: 128

      timestamps()
    end

    create table(:contacts) do
      add :user_id, references(:users)

      add :contact_id, :integer

      timestamps()
    end

    create table(:chat_servers) do
      add :name, :string, size: 128
      add :description, :string, size: 512

      timestamps()
    end

    create table(:roles) do
      add :role_name, :string, size: 128

      timestamps()
    end

    create table(:permissions) do
      add :permission, :string, size: 128

      add :role_id, references(:roles)

      timestamps()
    end

    create table(:chat_server_memberships) do
      add :membership_status, :string, size: 128
      add :join_timestamp, :utc_datetime

      add :user_id, references(:users)
      add :chat_server_id, references(:chat_servers)
      add :role_id, references(:roles)

      timestamps()
    end

    create table(:chat_rooms) do
      add :name, :string, size: 128
      add :description, :string, size: 512
      add :type, :string, size: 64

      add :chat_server_id, references(:chat_servers)

      timestamps()
    end

    create table(:chat_room_memberships) do
      add :membership_status, :string, size: 128
      add :join_timestamp, :utc_datetime

      add :user_id, references(:users)
      add :chat_room_id, references(:chat_rooms)
      add :role_id, references(:roles)

      timestamps()
    end

    create table(:chat_message) do
      add :text, :string
      add :type, :string, size: 32
      add :sent_at, :utc_datetime

      add :user_id, references(:users)
      add :chat_room, references(:chat_rooms)

      timestamps()
    end
  end
end
