defmodule NovaNodeWeb.Router do
  use NovaNodeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NovaNodeWeb do
    pipe_through :api

    post "/entries", EntryController, :create

    get "/tokens", TokenController, :index
    get "/tokens/:id", TokenController, :show
    post "/tokens", TokenController, :create
    post "/tokens/random", TokenController, :create_random

    get "/query/sources", QueryController, :list_sources
    get "/query/by_source", QueryController, :list_by_source
  end
end
