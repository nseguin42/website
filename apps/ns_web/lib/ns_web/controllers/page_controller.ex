defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    commit = get_commit()
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      repo_url: "https://github.com/nseguin42/website" |> URI.encode()
    )
  end

  defp get_commit() do
    commit = Mix.Project.config()[:commit]

    if commit == nil do
      nil
    else
      commit |> String.split(" ")
    end
  end

  defp get_sha(commit) do
    if commit == nil do
      nil
    else
      commit["sha"]
    end
  end

  defp get_message(commit) do
    if commit == nil do
      nil
    else
      commit["commit"]["message"]
      |> String.split("\n")
      |> List.first()
      |> String.slice(0..50)
      |> String.trim()
    end
  end

  defp get_url(commit) do
    if commit == nil do
      nil
    else
      commit["html_url"]
    end
  end
end
