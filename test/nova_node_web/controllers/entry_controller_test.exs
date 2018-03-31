defmodule NovaNodeWeb.EntryControllerTest do
  use NovaNodeWeb.ConnCase

  @entry_params %{
    "source" => "some.source",
    "data" => %{"value" => 5},
    "ts" => "2018-03-30 13:00:00"
  }

  test "create/2 with entry param responds with ok", %{conn: conn} do
    response =
      conn
      |> post(entry_path(conn, :create, entry: @entry_params))
      |> json_response(200)

    assert %{"data" => %{}} == response
  end

  test "create/2 with entries param responds with ok", %{conn: conn} do
    response =
      conn
      |> post(entry_path(conn, :create), %{entries: [@entry_params, @entry_params]})
      |> json_response(200)

    assert %{"data" => %{}} == response
  end

  test "create/2 with no param responds with 400 error", %{conn: conn} do
    response =
      conn
      |> post(entry_path(conn, :create), %{})
      |> json_response(400)

    assert %{"errors" => %{"detail" => "Bad Request"}} = response
  end

  test "create/2 with bad params responds with 400 error", %{conn: conn} do
    response =
      conn
      |> post(entry_path(conn, :create), %{entry: %{}})
      |> json_response(400)

    assert %{"errors" => %{"detail" => "Bad Request"}} = response
  end
end
