defmodule DS.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    Logger.info "starting dynamic_store"

    # List all child processes to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, KvPlug, [], [port: 5000]),
      DB,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DS.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
