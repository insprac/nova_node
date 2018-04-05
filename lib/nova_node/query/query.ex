defmodule NovaNode.Query do
  import Ecto.Query

  alias NovaNode.Repo
  alias NovaNode.Data.Entry

  def list_sources do
    Repo.all(from e in Entry, select: e.source, distinct: true)
  end

  def list_by_source(source) do
    Repo.all(from e in Entry, where: e.source == ^source)
  end
end
