# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :ns,
  ecto_repos: [Ns.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ns, Ns.Mailer, adapter: Swoosh.Adapters.Local

config :ns_web,
  ecto_repos: [Ns.Repo],
  generators: [context_app: :ns]

# Configures the endpoint
config :ns_web, NsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: NsWeb.ErrorHTML, json: NsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Ns.PubSub,
  live_view: [signing_salt: "RHOSaAuz"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --external:/prism-components/* --external:/latex/*),
    cd: Path.expand("../apps/ns_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/ns_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Support Markdown template engine
config :phoenix, :template_engines, md: NsWeb.Markdown.Engine

# Support LaTeX template engine
config :phoenix, :template_engines, tex: NsWeb.LaTeX.Engine

config :ns_web, :markdown, %{
  class: "prose m-auto",
  earmark: %{
    gfm: true,
    breaks: true,
    smartypants: false,
    code_class_prefix: "lang-"
  }
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
