defmodule NovaNodeWeb.EntryController do
  use NovaNodeWeb, :controller

  alias NovaNode.Data

  def create(conn, params) do
    cond do
      Map.has_key?(params, "entries") ->
        render_create(conn, Data.create_entries(params["entries"]))
      Map.has_key?(params, "entry") ->
        render_create(conn, Data.create_entry(params["entry"]))
      true ->
        render_create(conn, {:error, :missing_params})
    end
  end

  def render_create(conn, {:ok, _}) do
    render(conn, "empty.json")
  end

  def render_create(conn, {:error, _}) do
    conn
    |> put_status(400)
    |> render(NovaNodeWeb.ErrorView, "400.json", [])
  end
end

