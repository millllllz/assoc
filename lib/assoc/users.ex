defmodule Assoc.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Assoc.Repo

  alias Assoc.Users.User
  alias Assoc.Users.UserRole

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> put_roles(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> Repo.preload(:roles)
    |> User.changeset(attrs)
    |> put_roles(attrs)
    |> Repo.update()
  end

  defp put_roles(changeset, attrs) do
    {_, roles} =
      attrs
      |> Map.get("user_roles")
      |> Map.values()
      |> Enum.map_reduce([], fn admin_role, acc ->
        case admin_role do
          %{"role_id" => "false"} ->
            {nil, acc}

          %{"role_id" => role_id} ->
            {nil, acc ++ [Assoc.Roles.get_role!(role_id)]}
        end
      end)

    Ecto.Changeset.put_assoc(changeset, :roles, roles)
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user
    |> Repo.preload(:roles)
    |> add_roles_to_changeset()
    |> User.changeset(%{})
  end

  defp add_roles_to_changeset(user) do
    all_roles = Assoc.Roles.list_roles()
    all_user_roles = user.roles

    user_roles =
      Enum.map(all_roles, fn role ->
        if Enum.member?(all_user_roles, role) do
          %UserRole{user: user, role: role}
        else
          %UserRole{user: nil, role: role}
        end
      end)

    %{user | user_roles: user_roles}
  end
end
