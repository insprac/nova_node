defmodule NovaNode.Security.Token do
  use Ecto.Schema
  import Ecto.Changeset

  alias NovaNode.Security.Token

  schema "tokens" do
    field :key, :string
    field :secret, :string

    timestamps()
  end

  def changeset(%Token{} = token, attrs \\ %{}) do
    token
    |> cast(attrs, [:key, :secret])
    |> validate_required([:key, :secret])
  end
end
