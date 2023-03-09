defmodule Ns.Version do
  @moduledoc """
  The Version context.
  """

  import Ecto.Query, warn: false
  alias Ns.Repo

  alias Ns.Version.Commit

  @doc """
  Returns the list of commits.

  ## Examples

      iex> list_commits()
      [%Commit{}, ...]

  """
  def list_commits do
    Repo.all(Commit)
  end

  @doc """
  Gets a single commit.

  Raises `Ecto.NoResultsError` if the Commit does not exist.

  ## Examples

      iex> get_commit!(123)
      %Commit{}

      iex> get_commit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_commit!(id), do: Repo.get!(Commit, id)

  @doc """
  Gets the most recent commits, up to a limit.
  """

  def get_commits_since(days, limit) do
    Repo.all(
      from(c in Commit,
        order_by: [desc: c.timestamp],
        limit: ^limit
      )
    )
  end

  @doc """
  Creates a commit.

  ## Examples

      iex> create_commit(%{field: value})
      {:ok, %Commit{}}

      iex> create_commit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_commit(attrs \\ %{}) do
    %Commit{}
    |> Commit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a commit.

  ## Examples

      iex> update_commit(commit, %{field: new_value})
      {:ok, %Commit{}}

      iex> update_commit(commit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_commit(%Commit{} = commit, attrs) do
    commit
    |> Commit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a commit.

  ## Examples

      iex> delete_commit(commit)
      {:ok, %Commit{}}

      iex> delete_commit(commit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_commit(%Commit{} = commit) do
    Repo.delete(commit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking commit changes.

  ## Examples

      iex> change_commit(commit)
      %Ecto.Changeset{data: %Commit{}}

  """
  def change_commit(%Commit{} = commit, attrs \\ %{}) do
    Commit.changeset(commit, attrs)
  end

  @doc """
  Returns the newest commit.
  """

  def get_newest_commit do
    Repo.one(from(c in Commit, order_by: [desc: c.timestamp]))
  end
end
