defmodule PhoneFinder.Repo do
  use Ecto.Repo,
    otp_app: :phone_finder,
    adapter: Ecto.Adapters.Postgres
end
