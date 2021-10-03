import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :phone_finder, PhoneFinder.Repo,
  username: "postgres",
  password: "postgres",
  database: "phone_finder_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phone_finder, PhoneFinderWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "luV0vFxtWyq7OtSvRG1hDQIeVLk1LPLeDA6UfwsRnDEEF+3CLrxSaUQ1H96QlE7r",
  server: false

# In test we don't send emails.
config :phone_finder, PhoneFinder.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
