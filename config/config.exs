# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :adrenaline,
  ecto_repos: [Adrenaline.Repo]

# Configures the endpoint
config :adrenaline, Adrenaline.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CN3CjqCt/Z8a8jICCtMnjGC0m0QepwiSICkBS/NpOlwN4PRgZHAS0bxkmxvTMJCx",
  render_errors: [view: Adrenaline.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Adrenaline.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
