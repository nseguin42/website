defmodule Ns.Repo do
  use Ecto.Repo,
    otp_app: :ns,
    adapter: Ecto.Adapters.Postgres
end
