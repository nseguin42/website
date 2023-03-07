defmodule NsWeb.GitHubClient do
  use GenServer
  require Logger

  @repo "website"
  @owner "nseguin42"

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(_args) do
    commit = get_website_commit()
    {:ok, commit}
  end

  @impl true
  def handle_call(:get, _from, commit) do
    {:reply, commit, commit}
  end

  @impl true
  def handle_call(:get_commit_message, _from, commit) do
    if commit == nil do
      {:reply, nil, commit}
    else
      message = commit["message"] |> String.split("\n") |> List.first() |> String.trim()
      {:reply, message, commit}
    end
  end

  @impl true
  def handle_call(:get_short_sha, _from, commit) do
    if commit == nil do
      {:reply, nil, commit}
    else
      sha = commit["tree"]["sha"] |> String.slice(0..6)
      {:reply, sha, commit}
    end
  end

  @impl true
  def handle_call(:get_repo_url, _from, commit) do
    url = get_repo_url(@owner, @repo)
    {:reply, url, commit}
  end

  @impl true
  def handle_call(:get_commit_url, _from, commit) do
    if commit == nil do
      {:reply, nil, commit}
    else
      url = commit["commit"]["html_url"]
      {:reply, url, commit}
    end
  end

  defp get_website_commit() do
    sha = Application.get_env(:ns_web, :sha)
    Logger.info("SHA: #{sha}")

    case get_github_commit("nseguin42", "website", sha) do
      nil ->
        nil

      commit ->
        commit
    end
  end

  defp get_github_commit(owner, repo, sha) do
    if sha == nil do
      nil
    else
      case HTTPoison.get("https://api.github.com/repos/#{owner}/#{repo}/commits/#{sha}") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body
          |> Jason.decode!()
          |> Map.get("commit")

        _ ->
          nil
      end
    end
  end

  defp get_repo_url(owner, repo) do
    "https://github.com/#{owner}/#{repo}"
  end

  defp get_commit_url(owner, repo, sha) do
    "https://github.com/repos/#{owner}/#{repo}/commits/#{sha}"
  end
end
