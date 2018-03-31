defmodule NovaNode.Data.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  alias NovaNode.Data.Entry

  schema "entries" do
    field :source, :string
    field :data, :map
    field :ts, :naive_datetime
  end

  def changeset(%Entry{} = entry, attrs \\ %{}) do
    entry
    |> cast(attrs, [:source, :data, :ts])
    |> validate_required([:source, :data, :ts])
  end
end
