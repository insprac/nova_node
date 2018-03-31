defmodule NovaNodeWeb.TokenView do
  use NovaNodeWeb, :view

  alias NovaNodeWeb.TokenView

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token, TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    %{id: token.id,
      key: token.key,
      inserted_at: token.inserted_at,
      updated_at: token.updated_at}
  end

  def render("show-full.json", %{token: token}) do
    %{data: render_one(token, TokenView, "token-full.json")}
  end

  def render("token-full.json", %{token: token}) do
    %{id: token.id,
      key: token.key,
      secret: token.secret,
      inserted_at: token.inserted_at,
      updated_at: token.updated_at}
  end
end
