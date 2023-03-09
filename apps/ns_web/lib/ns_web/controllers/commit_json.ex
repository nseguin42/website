defmodule NsWeb.CommitJSON do
  alias Ns.Version.Commit

  @doc """
  Renders a list of commits.
  """
  def index(%{commits: commits}) do
    %{data: for(commit <- commits, do: data(commit))}
  end

  @doc """
  Renders a single commit.
  """
  def show(%{commit: commit}) do
    %{data: data(commit)}
  end

  defp data(%Commit{} = commit) do
    %{
      id: commit.id,
      sha: commit.sha,
      author: commit.author,
      timestamp: commit.timestamp,
      message: commit.message,
      url: commit.url
    }
  end
end
