defmodule NovaNodeWeb.QueryController do
  use NovaNodeWeb, :controller

  alias NovaNode.Query
  alias NovaNodeWeb.EntryView

  def list_sources(conn, _params) do
    render(conn, "result.json", result: Query.list_sources())
  end

  def list_by_source(conn, %{"source" => source}) do
    render(conn, EntryView, "index.json", entries: Query.list_by_source(source))
  end
end
