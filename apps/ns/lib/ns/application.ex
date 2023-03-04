defmodule Ns.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ns.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ns.PubSub},
      # Start Finch
      {Finch, name: Ns.Finch}
      # Start a worker by calling: Ns.Worker.start_link(arg)
      # {Ns.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Ns.Supervisor)
  end
end
