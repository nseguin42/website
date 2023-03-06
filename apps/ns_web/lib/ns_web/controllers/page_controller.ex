defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    commit = get_commit()
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      commit_sha: commit["sha"] |> String.slice(0..6),
      commit_message:
        commit["commit"]["message"]
        |> String.split("\n")
        |> List.first()
        |> String.slice(0..50)
        |> String.trim(),
      commit_url: commit["html_url"],
      repo_url: "https://github.com/nseguin42/website"
    )
  end

  defp get_commit() do
    Mix.Project.config()[:commit] |> Jason.decode!()
  end
end
