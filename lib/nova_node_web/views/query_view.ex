defmodule NovaNodeWeb.QueryView do
  use NovaNodeWeb, :view

  def render("result.json", %{result: result}) do
    %{data: result}
  end
end
