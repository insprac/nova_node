defmodule NovaNode.Factory do
  alias NovaNode.Data
  alias NovaNode.Security

  @token_attrs %{
    key: "abc123",
    secret: "def456"
  }

  @entry_attrs %{
    source: "some.source",
    ts: "2018-03-30 12:58:00.000000",
    data: %{
      "value" => 1,
      "map_value" => %{"value" => 2}
    }
  }

  def get_token_attrs, do: @token_attrs

  def get_entry_attrs, do: @entry_attrs

  def fixture(type) do
    fixture(type, %{})
  end

  def fixture(:token, attrs) do
    {:ok, token} =
      attrs
      |> Enum.into(@token_attrs)
      |> Security.create_token()

    token
  end

  def fixture(:entry, attrs) do
    {:ok, entry} =
      attrs
      |> Enum.into(@entry_attrs)
      |> Data.create_entry()

    entry
  end
end
