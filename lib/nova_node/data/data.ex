defmodule NovaNode.Data do
  alias NovaNode.Repo
  alias NovaNode.Data.Entry

  def list_entries do
    Repo.all(Entry)
  end

  def get_entry!(id) do
    Repo.get!(Entry, id)
  end

  def create_entry(attrs) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  def create_entries(attrs_list) do
    results = Enum.map(attrs_list, &create_entry(&1))

    case Enum.any?(results, fn {r, _} -> r == :ok end) do
      true -> {:ok, results}
      false -> {:error, results}
    end
  end
end
