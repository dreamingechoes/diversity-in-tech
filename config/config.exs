# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :diversity_in_tech, ecto_repos: [DiversityInTech.Repo]

# Configures the endpoint
config :diversity_in_tech, DiversityInTechWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PPcdK0rCZEMVH+e77Cz4r8Pcd1hiP3PL/zvoyadX73y5KpwfSI3VyljN4mEsIjV/",
  render_errors: [view: DiversityInTechWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DiversityInTech.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :diversity_in_tech, DiversityInTech.Guardian,
  issuer: "diversity_in_tech",
  secret_key: System.get_env("DIVERSITY_IN_TECH_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
