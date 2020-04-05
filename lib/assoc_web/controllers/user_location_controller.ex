defmodule AssocWeb.UserLocationController do
  use AssocWeb, :controller

  alias Assoc.UserLocations
  alias Assoc.UserLocations.UserLocation

  def index(conn, _params) do
    user_locations = UserLocations.list_user_locations()
    render(conn, "index.html", user_locations: user_locations)
  end

  def new(conn, _params) do
    changeset = UserLocations.change_user_location(%UserLocation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_location" => user_location_params}) do
    case UserLocations.create_user_location(user_location_params) do
      {:ok, user_location} ->
        conn
        |> put_flash(:info, "User location created successfully.")
        |> redirect(to: Routes.user_location_path(conn, :show, user_location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_location = UserLocations.get_user_location!(id)
    render(conn, "show.html", user_location: user_location)
  end

  def edit(conn, %{"id" => id}) do
    user_location = UserLocations.get_user_location!(id)
    changeset = UserLocations.change_user_location(user_location)
    render(conn, "edit.html", user_location: user_location, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_location" => user_location_params}) do
    user_location = UserLocations.get_user_location!(id)

    case UserLocations.update_user_location(user_location, user_location_params) do
      {:ok, user_location} ->
        conn
        |> put_flash(:info, "User location updated successfully.")
        |> redirect(to: Routes.user_location_path(conn, :show, user_location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_location: user_location, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_location = UserLocations.get_user_location!(id)
    {:ok, _user_location} = UserLocations.delete_user_location(user_location)

    conn
    |> put_flash(:info, "User location deleted successfully.")
    |> redirect(to: Routes.user_location_path(conn, :index))
  end
end
