# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hoja,
  ecto_repos: [Hoja.Repo]

# Configures the endpoint
config :hoja, HojaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bxLOcLnKvEgfkbhmMBgxc8dPoyq+l2IYoMJHT7bipHP+09j+uwpyGY0B8qESylx1",
  render_errors: [view: HojaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Hoja.PubSub,
  live_view: [signing_salt: "9dImulni"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
