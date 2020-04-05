defmodule AssocWeb.Router do
  use AssocWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AssocWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources("/users", UserController)
    resources("/roles", RoleController)
    resources("/locations", LocationController)
    resources("/user_locations", UserLocationController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", AssocWeb do
  #   pipe_through :api
  # end
end
