defmodule Assoc.Users.UserRole do
  use Ecto.Schema

  @primary_key false

  schema "user_roles" do
    belongs_to(:user, Assoc.Users.User)
    belongs_to(:role, Assoc.Roles.Role)
  end
end
