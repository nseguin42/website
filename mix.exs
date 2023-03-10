defmodule Ns.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      test_paths: ["test"],
      test_pattern: "**/*_test.exs",
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      releases: [
        ns_umbrella: [
          applications: [
            ns: :permanent,
            ns_web: :permanent
          ],
          overlays: "apps/ns_web/rel/overlays"
        ]
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp deps do
    [
      # Required to run "mix format" on ~H/.heex files from the umbrella root
      {:phoenix_live_view, ">= 0.0.0"},

      # HTTP Client
      {:hackney, "~> 1.18"},

      # HTTP server
      {:plug_cowboy, "~> 2.6"},
      {:plug_canonical_host, "~> 2.0"},
      {:corsica, "~> 1.3"},

      # Errors
      {:sentry, "~> 8.0"},

      # Monitoring
      {:new_relic_agent, "~> 1.27"},

      # Linting
      {:credo, "~> 1.6", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 2.0", only: [:dev, :test], runtime: false},

      # Security check
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},

      # Test factories
      {:ex_machina, "~> 2.7", only: :test},
      {:faker, "~> 0.17", only: :test},

      # Test coverage
      {:excoveralls, "~> 0.15", only: :test},

      # Dialyzer
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/ns_umbrella.plt"},
      plt_add_apps: [:mix, :ex_unit]
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  #
  # Aliases listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp aliases do
    [
      # run `mix setup` in all child apps
      setup: ["cmd mix setup"]
    ]
  end
end
