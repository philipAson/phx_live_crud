defmodule PhxLiveCrud.Repo do
  use Ecto.Repo,
    otp_app: :phx_live_crud,
    adapter: Ecto.Adapters.Postgres
end
