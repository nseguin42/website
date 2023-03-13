import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ns, Ns.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ns_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ns_web, NsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Q7vMymWqDcq4VOFfTcq3GGspBwHNXn8ZokZDH1zlspnXmATlXYXbpNdwoV/TAw4N",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :ns, Ns.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :plug_content_security_policy,
  nonces_for: [:script_src, :style_src],
  report_only: false,
  directives: %{
    default_src: ~w('self'),
    connect_src: ~w('self'),
    child_src: ~w('self'),
    img_src: ~w('self' data:),
    font_src: ~w('self' data: cdn.jsdelivr.net),
    script_src: ~w('self' 'unsafe-eval' 'unsafe-inline' cdn.jsdelivr.net),
    style_src: ~w('self')
  }
