defmodule NsWeb.CommitController do
  use NsWeb, :controller

  alias Ns.Version
  alias Ns.Version.Commit

  action_fallback(NsWeb.FallbackController)

  def index(conn, _params) do
    commits = Version.list_commits()
    render(conn, :index, commits: commits)
  end

  def create(conn, %{"commit" => commit_params}) do
    with {:ok, %Commit{} = commit} <- Version.create_commit(commit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/commits/#{commit}")
      |> render(:show, commit: commit)
    end
  end

  def show(conn, %{"id" => id}) do
    commit = Version.get_commit!(id)
    render(conn, :show, commit: commit)
  end

  def update(conn, %{"id" => id, "commit" => commit_params}) do
    commit = Version.get_commit!(id)

    with {:ok, %Commit{} = commit} <- Version.update_commit(commit, commit_params) do
      render(conn, :show, commit: commit)
    end
  end

  def delete(conn, %{"id" => id}) do
    commit = Version.get_commit!(id)

    with {:ok, %Commit{}} <- Version.delete_commit(commit) do
      send_resp(conn, :no_content, "")
    end
  end

  defp convert_from_github_json(json) do
    %{
      "sha" => sha,
      "commit" => %{
        "author" => %{
          "name" => author,
          "date" => timestamp
        },
        "message" => message
      },
      "html_url" => url
    } = json

    %{
      "sha" => sha,
      "author" => author,
      "timestamp" => timestamp,
      "message" => message,
      "url" => url
    }
  end
end
