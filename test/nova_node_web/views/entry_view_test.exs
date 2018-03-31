defmodule NovaNodeWeb.EntryViewTest do
  use NovaNodeWeb.ConnCase, async: true
  import Phoenix.View

  alias NovaNodeWeb.EntryView

  test "renders empty.json" do
    assert render(EntryView, "empty.json", []) == %{data: %{}}
  end
end
