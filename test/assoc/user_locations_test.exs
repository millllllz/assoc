defmodule Assoc.UserLocationsTest do
  use Assoc.DataCase

  alias Assoc.UserLocations

  describe "user_locations" do
    alias Assoc.UserLocations.UserLocation

    @valid_attrs %{display_order: "some display_order"}
    @update_attrs %{display_order: "some updated display_order"}
    @invalid_attrs %{display_order: nil}

    def user_location_fixture(attrs \\ %{}) do
      {:ok, user_location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserLocations.create_user_location()

      user_location
    end

    test "list_user_locations/0 returns all user_locations" do
      user_location = user_location_fixture()
      assert UserLocations.list_user_locations() == [user_location]
    end

    test "get_user_location!/1 returns the user_location with given id" do
      user_location = user_location_fixture()
      assert UserLocations.get_user_location!(user_location.id) == user_location
    end

    test "create_user_location/1 with valid data creates a user_location" do
      assert {:ok, %UserLocation{} = user_location} =
               UserLocations.create_user_location(@valid_attrs)

      assert user_location.display_order == "some display_order"
    end

    test "create_user_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserLocations.create_user_location(@invalid_attrs)
    end

    test "update_user_location/2 with valid data updates the user_location" do
      user_location = user_location_fixture()

      assert {:ok, %UserLocation{} = user_location} =
               UserLocations.update_user_location(user_location, @update_attrs)

      assert user_location.display_order == "some updated display_order"
    end

    test "update_user_location/2 with invalid data returns error changeset" do
      user_location = user_location_fixture()

      assert {:error, %Ecto.Changeset{}} =
               UserLocations.update_user_location(user_location, @invalid_attrs)

      assert user_location == UserLocations.get_user_location!(user_location.id)
    end

    test "delete_user_location/1 deletes the user_location" do
      user_location = user_location_fixture()
      assert {:ok, %UserLocation{}} = UserLocations.delete_user_location(user_location)

      assert_raise Ecto.NoResultsError, fn ->
        UserLocations.get_user_location!(user_location.id)
      end
    end

    test "change_user_location/1 returns a user_location changeset" do
      user_location = user_location_fixture()
      assert %Ecto.Changeset{} = UserLocations.change_user_location(user_location)
    end
  end
end
