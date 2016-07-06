use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :photo_feed_api, PhotoFeedApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :photo_feed_api, s3_client: PhotoFeedApi.PhotoTest.MockS3

# Configure your database
config :photo_feed_api, PhotoFeedApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "furball",
  password: "",
  database: "photo_feed_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
