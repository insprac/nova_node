defmodule NovaNode.QueryTest do
  use NovaNode.DataCase

  alias NovaNode.Query

  @entry_attrs get_entry_attrs()

  test "list_sources/0 returns all created sources" do
    fixture(:entry, %{source: "some.thing"})
    fixture(:entry, %{source: "some.thing"})
    fixture(:entry, %{source: "some.thing.else"})

    assert ["some.thing.else", "some.thing"] == Query.list_sources
  end

  test "list_by_source/1 returns all entries with given source" do
    source1 = fixture(:entry, %{source: "some.thing"})
    source2 = fixture(:entry, %{source: "some.thing"})
    source3 = fixture(:entry, %{source: "some.thing.else"})

    assert [source1, source2] == Query.list_by_source("some.thing")
  end
end
