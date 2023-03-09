defmodule Ns.Version.Commit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "commits" do
    field(:author, :string)
    field(:message, :string)
    field(:sha, :string)
    field(:timestamp, :naive_datetime)
    field(:url, :string)

    timestamps()
  end

  @doc false
  def changeset(commit, attrs) do
    commit
    |> cast(attrs, [:sha, :author, :timestamp, :message, :url])
    |> validate_required([:sha, :author, :timestamp, :message, :url])
  end
end
