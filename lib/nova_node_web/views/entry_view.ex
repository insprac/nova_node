defmodule NovaNodeWeb.EntryView do
  use NovaNodeWeb, :view

  alias NovaNodeWeb.EntryView

  def render("index.json", %{entries: entries}) do
    %{data: render_many(entries, EntryView, "entry.json")}
  end

  def render("entry.json", %{entry: entry}) do
    %{id: entry.id,
      ts: entry.ts,
      source: entry.source,
      data: entry.data}
  end

  def render("empty.json", %{}) do
    %{data: %{}}
  end
end
