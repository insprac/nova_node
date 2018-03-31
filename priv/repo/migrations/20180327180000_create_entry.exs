defmodule NovaNode.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :source, :string
      add :data, :map
      add :ts, :naive_datetime
    end
  end
end
