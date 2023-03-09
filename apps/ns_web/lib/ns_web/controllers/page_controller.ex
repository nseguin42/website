defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      repo_url: "https://github.com/nseguin42/website" |> URI.encode()
    )
  end

  def sha(conn, _params) do
    sha = File.read!("sha.txt") |> String.trim()

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, sha)
  end
end
