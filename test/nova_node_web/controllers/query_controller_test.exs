defmodule NovaNodeWeb.QueryControllerTest do
  use NovaNodeWeb.ConnCase

  test "list_sources/2 responds with a list of all created sources", %{conn: conn} do
    fixture(:entry, %{source: "some.thing"})
    fixture(:entry, %{source: "some.thing.else"})

    response =
      conn
      |> get(query_path(conn, :list_sources, %{}))
      |> json_response(200)

    assert %{"data" => ["some.thing.else", "some.thing"]} == response
  end

  test "list_by_source/2 responds with all entries with given source", %{conn: conn} do
    entry1 = fixture(:entry, %{source: "some.thing"})
    entry2 = fixture(:entry, %{source: "some.thing"})

    response =
      conn
      |> get(query_path(conn, :list_by_source, source: "some.thing"))
      |> json_response(200)

    assert Enum.at(response["data"], 0)["id"] == entry1.id
    assert Enum.at(response["data"], 1)["id"] == entry2.id
  end
end
