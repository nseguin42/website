import Config

# Configure your database
config :ns, Ns.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ns_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :ns_web, NsWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [port: 4000],
  https: [
    port: 4001,
    cipher_suite: :strong,
    otp_app: :ns_web,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "kftZiHYbS+m7NFl/kJmYjcpvjwiQQarBOno+cFnFnE2WPmG2raTe+vnlSUMmPJwJ",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

# Watch static and templates for browser reloading.
config :ns_web, NsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/ns_web/(controllers|live|components)/.*(ex|heex|md|tex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :ns_web, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :plug_content_security_policy,
  report_only: false,
  directives: %{
    connect_src: ~w('self'),
    child_src: ~w('self'),
    font_src: ~w('self' data: cdn.jsdelivr.net),
    img_src: ~w('self' data:),
    script_src: ~w('self' 'unsafe-eval' 'unsafe-inline' cdn.jsdelivr.net),
    style_src: ~w('self' 'unsafe-inline')
  }
