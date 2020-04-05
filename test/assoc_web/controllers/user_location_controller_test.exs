defmodule AssocWeb.UserLocationControllerTest do
  use AssocWeb.ConnCase

  alias Assoc.UserLocations

  @create_attrs %{display_order: "some display_order"}
  @update_attrs %{display_order: "some updated display_order"}
  @invalid_attrs %{display_order: nil}

  def fixture(:user_location) do
    {:ok, user_location} = UserLocations.create_user_location(@create_attrs)
    user_location
  end

  describe "index" do
    test "lists all user_locations", %{conn: conn} do
      conn = get(conn, Routes.user_location_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User locations"
    end
  end

  describe "new user_location" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_location_path(conn, :new))
      assert html_response(conn, 200) =~ "New User location"
    end
  end

  describe "create user_location" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_location_path(conn, :create), user_location: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_location_path(conn, :show, id)

      conn = get(conn, Routes.user_location_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User location"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_location_path(conn, :create), user_location: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User location"
    end
  end

  describe "edit user_location" do
    setup [:create_user_location]

    test "renders form for editing chosen user_location", %{
      conn: conn,
      user_location: user_location
    } do
      conn = get(conn, Routes.user_location_path(conn, :edit, user_location))
      assert html_response(conn, 200) =~ "Edit User location"
    end
  end

  describe "update user_location" do
    setup [:create_user_location]

    test "redirects when data is valid", %{conn: conn, user_location: user_location} do
      conn =
        put(conn, Routes.user_location_path(conn, :update, user_location),
          user_location: @update_attrs
        )

      assert redirected_to(conn) == Routes.user_location_path(conn, :show, user_location)

      conn = get(conn, Routes.user_location_path(conn, :show, user_location))
      assert html_response(conn, 200) =~ "some updated display_order"
    end

    test "renders errors when data is invalid", %{conn: conn, user_location: user_location} do
      conn =
        put(conn, Routes.user_location_path(conn, :update, user_location),
          user_location: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit User location"
    end
  end

  describe "delete user_location" do
    setup [:create_user_location]

    test "deletes chosen user_location", %{conn: conn, user_location: user_location} do
      conn = delete(conn, Routes.user_location_path(conn, :delete, user_location))
      assert redirected_to(conn) == Routes.user_location_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_location_path(conn, :show, user_location))
      end
    end
  end

  defp create_user_location(_) do
    user_location = fixture(:user_location)
    {:ok, user_location: user_location}
  end
end
