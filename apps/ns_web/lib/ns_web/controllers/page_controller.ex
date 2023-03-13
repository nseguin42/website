defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    recent_commits = Ns.Version.get_recent_commits(3)
    publish_commit = NsWeb.GitHubClient.get_publish_commit()

    data = %{
      commit: publish_commit,
      commits: recent_commits
    }

    render(conn, :home,
      layout: false,
      repo_url: "https://github.com/nseguin42/website" |> URI.encode(),
      data: data
    )
  end

  def resume(conn, _params) do
    render(conn, :resume)
  end

  def test(conn, _params) do
    render(conn, :test)
  end

  def latex(conn, _params) do
    render(conn, :latex)
  end
end
