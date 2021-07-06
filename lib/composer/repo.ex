defmodule Composer.Repo do
  use Ecto.Repo,
    otp_app: :composer,
    adapter: Ecto.Adapters.Postgres
end
