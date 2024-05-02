defmodule PhxLiveCrud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxLiveCrudWeb.Telemetry,
      PhxLiveCrud.Repo,
      {DNSCluster, query: Application.get_env(:phx_live_crud, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxLiveCrud.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxLiveCrud.Finch},
      # Start a worker by calling: PhxLiveCrud.Worker.start_link(arg)
      # {PhxLiveCrud.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxLiveCrudWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxLiveCrud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxLiveCrudWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
