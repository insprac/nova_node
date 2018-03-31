defmodule NovaNode.DataTest do
  use NovaNode.DataCase

  alias NovaNode.Data
  alias NovaNode.Data.Entry

  @entry_attrs get_entry_attrs()

  test "create_entry/1 creates a valid entry" do
    assert {:ok, entry} = Data.create_entry(@entry_attrs)
    assert %Entry{} = entry
    assert entry.source == @entry_attrs.source
    assert entry.data == @entry_attrs.data
    assert entry.ts == NaiveDateTime.from_iso8601!(@entry_attrs.ts)
  end

  test "create_entry/1 returns a changeset when invalid" do
    assert {:error, changeset} = Data.create_entry(%{})
    assert %Ecto.Changeset{} = changeset
  end

  test "create_entries/1 creates valid entries from list" do
    assert {:ok, [
      {:ok, entry1},
      {:ok, entry2}
    ]} = Data.create_entries([@entry_attrs, @entry_attrs])
    assert %Entry{} = entry1
    assert %Entry{} = entry2
    assert entry1.source == @entry_attrs.source
    assert entry2.source == @entry_attrs.source
    assert entry1.data == @entry_attrs.data
    assert entry2.data == @entry_attrs.data
    assert entry1.ts == NaiveDateTime.from_iso8601!(@entry_attrs.ts)
    assert entry2.ts == NaiveDateTime.from_iso8601!(@entry_attrs.ts)
  end

  test "create_entries/1 success when atleast one entry is valid" do
    assert {:ok, [
      {:ok, entry},
      {:error, changeset}
    ]} = Data.create_entries([@entry_attrs, %{}])
    assert %Entry{} = entry
    assert %Ecto.Changeset{} = changeset
    assert entry.source == @entry_attrs.source
    assert entry.data == @entry_attrs.data
    assert entry.ts == NaiveDateTime.from_iso8601!(@entry_attrs.ts)
  end

  test "create_entries/1 fails when all entries are invalid" do
    assert {:error, [
      {:error, changeset1},
      {:error, changeset2}
    ]} = Data.create_entries([%{}, %{}])
    assert %Ecto.Changeset{} = changeset1
    assert %Ecto.Changeset{} = changeset2
  end

  test "list_entries/0 returns all entries" do
    entry1 = fixture(:entry)
    entry2 = fixture(:entry)

    assert [entry1, entry2] == Data.list_entries()
  end

  test "get_entry!/1 returns entry with given id" do
    entry = fixture(:entry)

    assert entry == Data.get_entry!(entry.id)
  end
end
