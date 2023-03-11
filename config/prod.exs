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
config :ns_web, NsWeb.Endpoint,
  url: [host: "nseguin.dev", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  https: [
    port: 443,
    otp_app: :ns_web,
    keyfile: "/etc/letsencrypt/live/nseguin.dev/privkey.pem",
    certfile: "/etc/letsencrypt/live/nseguin.dev/fullchain.pem",
    force_ssl: [rewrite_on: [:x_forwarded_proto], host: nil]
  ]

# Configures Swoosh API Client
config :swoosh, :api_client, Ns.Finch

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :plug_content_security_policy,
  nonces_for: [:script_src, :style_src],
  report_only: false,
  directives: %{
    default_src: ~w('self'),
    connect_src: ~w('self'),
    child_src: ~w('self'),
    img_src: ~w('self' data:),
    script_src: ~w('strict-dynamic' 'self' 'unsafe-eval' 'unsafe-inline'),
    style_src: ~w('self'),
    frame_ancestors: [
      "'self'",
      "http://nsegu.in",
      "https://nsegu.in",
      "http://nseguin.dev",
      "https://nseguin.dev"
    ]
  }
