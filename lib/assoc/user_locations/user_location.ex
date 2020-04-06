defmodule Assoc.UserLocations.UserLocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_locations" do
    belongs_to(:user, Assoc.Users.User)
    belongs_to(:location, Assoc.Locations.Location)

    field :display_order, :integer
    field :action, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user_location, attrs) do
    user_location
    |> cast(attrs, [:display_order, :location_id, :action])
    |> put_action()
  end

  def put_action(changeset) do
    case get_change(changeset, :action) do
      "insert" -> %{changeset | action: :insert}
      "update" -> %{changeset | action: :update}
      "delete" -> %{changeset | action: :delete}
      _ -> %{changeset | action: :ignore}
    end
  end
end
