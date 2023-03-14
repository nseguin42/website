import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
# Configures Swoosh API Client
config :swoosh, :api_client, Ns.Finch

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :plug_content_security_policy,
  report_only: false,
  directives: %{
    default_src: ~w('self'),
    connect_src: ~w('self' cdn.jsdelivr.net),
    child_src: ~w('self'),
    img_src: ~w('self' data:),
    font_src: ~w('self' data: cdn.jsdelivr.net),
    script_src: ~w('self' 'unsafe-eval' 'unsafe-inline' cdn.jsdelivr.net),
    style_src: ~w('self' 'unsafe-inline' cdn.jsdelivr.net),
    frame_ancestors: [
      "'self'",
      "http://nsegu.in",
      "https://nsegu.in",
      "https://nseguin.dev"
    ]
  }
