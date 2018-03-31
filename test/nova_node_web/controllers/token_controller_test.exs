defmodule NovaNodeWeb.TokenControllerTest do
  use NovaNodeWeb.ConnCase

  @token_params %{
    "key" => "abc123",
    "secret" => "def456"
  }

  def token_map(token) do
    %{"id" => token.id,
      "key" => token.key,
      "inserted_at" => NaiveDateTime.to_iso8601(token.inserted_at),
      "updated_at" => NaiveDateTime.to_iso8601(token.updated_at)}
  end

  test "index/2 responds with all tokens", %{conn: conn} do
    token1 = fixture(:token)
    token2 = fixture(:token)

    response =
      conn
      |> get(token_path(conn, :index))
      |> json_response(200)

    assert response == %{"data" => [token_map(token1), token_map(token2)]}
  end

  test "show/2 responds with token with given id", %{conn: conn} do
    token = fixture(:token)

    response =
      conn
      |> get(token_path(conn, :show, token.id))
      |> json_response(200)

    assert response == %{"data" => token_map(token)}
  end

  test "show/2 responds with 404 error when token does not exist with given id", %{conn: conn} do
    response =
      conn
      |> get(token_path(conn, :show, 1))
      |> json_response(404)

    assert response == %{"errors" => %{"detail" => "Not Found"}}
  end

  test "create/2 responds with created token", %{conn: conn} do
    response =
      conn
      |> post(token_path(conn, :create), %{"token" => @token_params})
      |> json_response(200)

    assert %{
      "data" => %{
        "id" => response["data"]["id"],
        "key" => @token_params["key"],
        "inserted_at" => response["data"]["inserted_at"],
        "updated_at" => response["data"]["updated_at"]
      }
    } == response
  end

  test "create_random/2 responds with randomly generated token", %{conn: conn} do
    response =
      conn
      |> post(token_path(conn, :create_random))
      |> json_response(200)

    assert %{
      "data" => %{
        "id" => _id,
        "key" => key,
        "secret" => secret,
        "inserted_at" => _inserted_at,
        "updated_at" => _updated_at
      }
    } = response
    assert String.length(key) == 32
    assert String.length(secret) == 64
  end
end
