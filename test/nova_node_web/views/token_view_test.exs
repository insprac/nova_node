defmodule NovaNodeWeb.TokenViewTest do
  use NovaNodeWeb.ConnCase, async: true
  import Phoenix.View

  alias NovaNodeWeb.TokenView

  test "renders token.json" do
    token = fixture(:token)

    assert %{
      id: token.id,
      key: token.key,
      inserted_at: token.inserted_at,
      updated_at: token.updated_at
    } == render(TokenView, "token.json", token: token)
  end

  test "renders token.json without 'secret'" do
    rendered = render(TokenView, "token.json", token: fixture(:token))

    assert false == Map.has_key?(rendered, :secret)
  end

  test "renders show.json" do
    token = fixture(:token)

    assert %{
      data: %{
        id: token.id,
        key: token.key,
        inserted_at: token.inserted_at,
        updated_at: token.updated_at
      }
    } == render(TokenView, "show.json", token: token)
  end

  test "renders index.json" do
    token = fixture(:token)

    assert %{
      data: [%{
        id: token.id,
        key: token.key,
        inserted_at: token.inserted_at,
        updated_at: token.updated_at
      }]
    } == render(TokenView, "index.json", tokens: [token])
  end

  test "renders token-full.json" do
    token = fixture(:token)

    assert %{
      id: token.id,
      key: token.key,
      secret: token.secret,
      inserted_at: token.inserted_at,
      updated_at: token.updated_at
    } == render(TokenView, "token-full.json", token: token)
  end

  test "renders show-full.json" do
    token = fixture(:token)

    assert %{
      data: %{
        id: token.id,
        key: token.key,
        secret: token.secret,
        inserted_at: token.inserted_at,
        updated_at: token.updated_at
      }
    } == render(TokenView, "show-full.json", token: token)
  end
end
