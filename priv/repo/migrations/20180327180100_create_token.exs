defmodule NovaNode.Repo.Migrations.CreateToken do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :key, :string
      add :secret, :string

      timestamps()
    end
  end
end
