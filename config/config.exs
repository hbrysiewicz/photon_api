# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :photo_feed_api,
  ecto_repos: [PhotoFeedApi.Repo]

# Configures the endpoint
config :photo_feed_api, PhotoFeedApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fSBTO9+xFNSWYqEgGtU2gVip9ufUPCTm0cRJx7XF9XsUIXGr41nk5nhqFNoa+riV",
  render_errors: [view: PhotoFeedApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhotoFeedApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :photo_feed_api, s3_client: PhotoFeedApi.S3

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
