defmodule Assoc.UserLocations.UserLocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_locations" do
    field :display_order, :string

    timestamps()
  end

  @doc false
  def changeset(user_location, attrs) do
    user_location
    |> cast(attrs, [:display_order])
    |> validate_required([:display_order])
  end
end
