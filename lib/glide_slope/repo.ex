defmodule GlideSlope.Repo do
  use Ecto.Repo,
    otp_app: :glide_slope,
    adapter: Ecto.Adapters.Postgres
end
