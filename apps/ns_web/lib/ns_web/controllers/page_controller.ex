defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    commit = Ns.Version.get_newest_commit()

    data = %{
      commit: commit
    }

    render(conn, :home,
      layout: false,
      repo_url: "https://github.com/nseguin42/website" |> URI.encode(),
      data: data
    )
  end
end
