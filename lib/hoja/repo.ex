defmodule Hoja.Repo do
  use Ecto.Repo,
    otp_app: :hoja,
    adapter: Ecto.Adapters.MyXQL
end
