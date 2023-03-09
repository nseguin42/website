defmodule NsWeb.PageController do
  use NsWeb, :controller

  def home(conn, _params) do
    recent_commits = Ns.Version.get_recent_commits(3)

    data = %{
      commit: recent_commits |> Enum.at(0),
      commits: recent_commits
    }

    render(conn, :home,
      layout: false,
      repo_url: "https://github.com/nseguin42/website" |> URI.encode(),
      data: data
    )
  end
end

defmodule NsWeb.PageComponents do
  use Phoenix.Component

  def vertical_expand_button(assigns) do
    ~H"""
    <button
      id={@id}
      class="flex items-center justify-center w-8 h-8 rounded-full hover:bg-nord_gray-100 focus:outline-none"
    >
      <svg
        class="w-6 h-6 text-nord_gray-900 transition transform group-hover:rotate-180"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <polyline points="6 9 12 15 18 9"></polyline>
      </svg>
    </button>
    """
  end
end

defmodule NsWeb.GitComponents do
  use Phoenix.Component

  def commits_panel(assigns) do
    ~H"""
    <div id="commits" class="flex flex-col items-center justify-center w-full">
      <div id="commits-header">
        <h2 class="text-2xl font-semibold leading-10 tracking-tighter text-nord-1">
          Recent Commits
        </h2>
      </div>
      <div id="commits-body" class="group relative px-2 py-2 rounded-2xl mt-4 overflow-hidden">
        <%= for commit <- @commits do %>
          <NsWeb.GitComponents.commit_pill commit={commit} />
        <% end %>
      </div>
      <div id="commits-footer" class="mt-4">
        <div class="flex items-center justify-center mt-4">
          <NsWeb.PageComponents.vertical_expand_button id="commits-toggle" />
        </div>
      </div>
    </div>
    """
  end

  def commit_pill(assigns) do
    ~H"""
    <div class="py-1 px-2 rounded-lg mt-2">
      <div class="bg-nord_blue-200 rounded-lg
      flex flex-col justify-between p-4
      transition duration-150 ease-in-out
      hover:bg-nord_gray-200
      focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-offset-nord_gray-50 focus-within:ring-nord-1
      ">
        <a
          href={@commit.url}
          aria-label="View commit on GitHub"
          title="View commit on GitHub"
          target="_blank"
          class="float-right"
        >
        </a>
        <div id="commit-lead" class="flex items-center">
          <span class="text-sm font-medium leading-6 text-nord_gray-900">
            <b><%= @commit.author %></b> <span class="text-nord_gray-600">committed</span>
            <span class="text-nord_gray-600" id="commit-date">
              <%= case DateTime.from_naive(@commit.timestamp, "Etc/UTC") do
                {:ok, timestamp} -> " on #{DateTime.to_date(timestamp)}:"
                _ -> ":"
              end %>
            </span>
          </span>
        </div>
        <div id="commit-message" class="flex items-center">
          <span class="text-sm font-medium leading-6 text-nord_gray-900">
            <%= @commit.message |> String.split("\n") |> Enum.at(0) %>
          </span>
        </div>
      </div>
    </div>
    """
  end
end
