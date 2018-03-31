defmodule NovaNodeWeb.EntryView do
  use NovaNodeWeb, :view

  def render("empty.json", %{}) do
    %{data: %{}}
  end
end
