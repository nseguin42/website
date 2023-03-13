defmodule NsWeb.PageComponents do
  use Phoenix.Component

  def logo(assigns) do
    ~H"""
    <svg viewBox="-100 -75 450 450" class="h-20" aria-hidden="true">
      <circle r="180" cx="100" cy="140" fill="#2e3440" stroke-width="0.186574" />
      <path
        d="m 4.1699795,217.74261 v -9.422 H 104.92015 205.67031 v 9.422 9.42201 H 104.92015 4.1699795 Z M 155.57509,197.1964 c -2.20881,-0.14424 -6.37854,-0.65975 -8.24622,-1.0195 -12.8608,-2.47724 -23.05984,-10.18843 -27.54326,-20.82463 -1.78018,-4.22318 -2.9247,-9.69198 -2.9247,-13.97488 v -1.19297 h 13.61992 13.61993 v 0.89861 c 0,3.18501 1.49674,7.00842 3.65694,9.34164 2.00246,2.16283 4.16862,3.3277 7.53753,4.05334 2.20095,0.47406 7.42422,0.47724 9.79515,0.006 4.43002,-0.88061 7.91921,-3.26909 9.66819,-6.61826 3.27307,-6.26769 1.46515,-13.82678 -4.80701,-20.09862 -3.0987,-3.09855 -5.96177,-5.06229 -12.23941,-8.39486 -9.79744,-5.20109 -15.51386,-8.65156 -20.03006,-12.09028 -7.72778,-5.88407 -13.64351,-13.514 -16.58487,-21.39066 -3.519,-9.423532 -3.01237,-20.612683 1.3227,-29.212317 3.77964,-7.497801 10.56527,-13.428066 18.88223,-16.502008 10.14168,-3.74836 26.43033,-3.945609 36.94172,-0.447348 11.85533,3.945531 19.86221,12.36108 22.84917,24.015364 0.66978,2.613334 1.21833,6.598018 1.2187,8.852883 v 1.352664 h -13.59221 -13.59222 l -0.10997,-1.558224 c -0.12341,-1.748872 -0.66531,-4.067359 -1.27382,-5.450103 -2.18704,-4.969621 -7.3885,-7.636474 -14.24014,-7.301082 -2.50073,0.122411 -5.23943,0.727918 -6.74648,1.491595 -3.18085,1.611862 -5.48116,4.547713 -6.53459,8.340029 -0.47121,1.696349 -0.47042,5.576049 0.001,7.339125 1.25929,4.704612 4.48684,9.246912 9.1796,12.918902 2.16946,1.69757 5.23071,3.50191 10.96305,6.46175 12.77731,6.59745 17.90062,10.06332 24.19697,16.36901 8.06457,8.07652 12.32238,17.26365 12.80197,27.6229 0.49756,10.74798 -4.04183,21.50027 -11.67623,27.65703 -6.27276,5.05866 -13.78528,8.02924 -22.77424,9.00532 -2.59436,0.28171 -11.00466,0.50214 -13.34007,0.34963 z M 8.2746156,127.25272 V 58.685317 l 12.4214544,0.04797 12.421453,0.04797 16.906702,43.793453 c 9.298685,24.0864 16.93171,43.76844 16.962276,43.73788 0.03057,-0.0306 -0.196629,-1.55174 -0.504877,-3.38038 -1.083757,-6.42924 -1.693096,-12.62913 -2.045145,-20.80895 -0.107907,-2.50719 -0.188886,-17.02637 -0.189128,-33.909896 L 64.246927,58.68797 h 13.619929 13.619929 v 68.56741 68.5674 l -12.421453,-0.048 -12.421454,-0.048 -16.906702,-43.79345 C 40.438491,127.84699 32.805467,108.16494 32.7749,108.19551 c -0.03057,0.0306 0.196629,1.55173 0.504878,3.38038 1.083756,6.42923 1.693095,12.62913 2.045144,20.80895 0.107907,2.50719 0.188886,17.02636 0.189129,33.90989 l 4.23e-4,29.5254 H 21.894545 8.2746156 Z"
        fill="#81a1c1"
        stroke-width="0.186574"
      />
    </svg>
    """
  end

  def vertical_expand_button(assigns) do
    ~H"""
    <button
      id={@id}
      class="flex items-center justify-center w-8 h-8 rounded-full hover:bg-slate-100 focus:outline-none"
    >
      <svg
        class="w-6 h-6 text-slate-900 transition transform group-hover:rotate-180"
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
      <div class="bg-blue-200 rounded-lg
      flex flex-col justify-between p-4
      transition duration-150 ease-in-out
      hover:bg-slate-200
      focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-offset-slate-50 focus-within:ring-nord-1
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
          <span class="text-sm font-medium leading-6 text-slate-900">
            <b><%= @commit.author %></b> <span class="text-slate-600">committed</span>
            <span class="text-slate-600" id="commit-date">
              <%= case DateTime.from_naive(@commit.timestamp, "Etc/UTC") do
                {:ok, timestamp} -> " on #{DateTime.to_date(timestamp)}:"
                _ -> ":"
              end %>
            </span>
          </span>
        </div>
        <div id="commit-message" class="flex items-center">
          <span class="text-sm font-medium leading-6 text-slate-900">
            <%= @commit.message |> String.split("\n") |> Enum.at(0) %>
          </span>
        </div>
      </div>
    </div>
    """
  end
end
