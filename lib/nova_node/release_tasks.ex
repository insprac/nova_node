defmodule NovaNode.ReleaseTasks do
  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto
  ]

  def seed do
    IO.puts "Loading nova_node.."
    :ok = Application.load(:nova_node)

    IO.puts "Starting dependencies.."
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    IO.puts "Starting repo.."
    NovaNode.Repo.start_link(pool_size: 1)

    IO.puts "Running migrations.."
    Ecto.Migrator.run(NovaNode.Repo, migrations_path(NovaNode.Repo), :up, all: true)

    IO.puts "Success!"
    :init.stop()
  end

  def migrations_path(repo), do: priv_path_for(repo, "migrations")

  def priv_path_for(repo, filename) do
    repo_underscore = repo |> Module.split |> List.last |> Macro.underscore
    Path.join([priv_dir(), repo_underscore, filename])
  end

  def priv_dir(), do: "#{:code.priv_dir(:nova_node)}"

end
