defmodule NovaNodeWeb.TokenController do
  use NovaNodeWeb, :controller

  alias NovaNode.Security

  def index(conn, _params) do
    tokens = Security.list_tokens()

    render(conn, "index.json", tokens: tokens)
  end

  def show(conn, %{"id" => id}) do
    case Security.get_token(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(NovaNodeWeb.ErrorView, "404.json", [])
      token ->
        render(conn, "show.json", token: token)
    end
  end

  def create(conn, %{"token" => token_params}) do
    {:ok, token} = Security.create_token(token_params)

    render(conn, "show.json", token: token)
  end

  def create_random(conn, _params) do
    {:ok, token} = Security.create_random_token()

    render(conn, "show-full.json", token: token)
  end
end
