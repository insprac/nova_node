defmodule NovaNodeWeb.ErrorViewTest do
  use NovaNodeWeb.ConnCase, async: true
  import Phoenix.View

  alias NovaNodeWeb.ErrorView

  test "renders 400.json" do
    assert render(ErrorView, "400.json", []) ==
           %{errors: %{detail: "Bad Request"}}
  end

  test "renders 401.json" do
    assert render(ErrorView, "401.json", []) ==
           %{errors: %{detail: "Unauthorized"}}
  end

  test "renders 404.json" do
    assert render(ErrorView, "404.json", []) ==
           %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal Server Error"}}
  end
end
