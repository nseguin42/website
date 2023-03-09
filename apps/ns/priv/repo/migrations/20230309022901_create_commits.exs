defmodule Ns.Repo.Migrations.CreateCommits do
  use Ecto.Migration

  def change do
    create table(:commits) do
      add :sha, :string
      add :author, :string
      add :timestamp, :naive_datetime
      add :message, :string
      add :url, :string

      timestamps()
    end
  end
end
