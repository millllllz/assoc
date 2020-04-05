defmodule Assoc.Repo.Migrations.CreateUserLocations do
  use Ecto.Migration

  def change do
    create table(:user_locations) do
      add :user_id, references(:users)
      add :location_id, references(:locations)
      add :display_order, :integer

      timestamps()
    end
  end
end
