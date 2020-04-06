defmodule Assoc.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string

    has_many(:user_roles, Assoc.Users.UserRole)
    many_to_many(:roles, Assoc.Roles.Role, join_through: "user_roles", on_replace: :delete)

    has_many(:user_locations, Assoc.UserLocations.UserLocation, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:user_locations)
  end
end
