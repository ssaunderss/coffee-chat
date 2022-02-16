import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a release
if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :coffee_chat, CoffeeChatWeb.Endpoint, server: true
end

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :coffee_chat, CoffeeChatWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :coffee_chat, CoffeeChat.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.


  ####################
  #  Database Setup  #
  ####################

  database_username =
    System.get_env("COCKROACH_USERNAME") ||
      raise """
      environment variable COCKROACH_USERNAME is missing.
      For example: bad_username
      """

  database_password =
    System.get_env("COCKROACH_PASSWORD") ||
      raise """
      environment variable COCKROACH_PASSWORD is missing.
      For example: Abc123
      """

  database_hostname =
    System.get_env("COCKROACH_HOSTNAME") ||
      raise """
      environment variable COCKROACH_HOSTNAME is missing.
      For example: example-tier.cloud-availability-zone.cockroachlabs.cloud
      """

  database_db =
    System.get_env("COCKROACH_DATABASE") ||
      raise """
      environment variable COCKROACH_DATABASE is missing.
      For example: coffee-chat
      """

  database_port =
    System.get_env("COCKROACH_PORT") ||
    raise """
    environment variable COCKROACH_PORT is missing.
    For example: 26257
    """

  database_ssl_ca_cert_path =
    System.get_env("COCKROACH_CA_CERT_PATH") ||
    raise """
    environment variable COCKROACH_CA_CERT_PATH is missing.
    For example: priv/certs/ca-cert.crt
    """

  database_cluster_name =
    System.get_env("COCKROACH_CLUSTER") ||
    raise """
    environment variable COCKROACH_CLUSTER is missing.
    For example: --cluster=cluster-name-1234
    """

  config :coffee_chat, CoffeeChat.Repo,
    username: database_username,
    password: database_password,
    hostname: database_hostname,
    database: database_db,
    port: database_port,
    ssl: true,
    ssl_opts: [
      cacertfile: Path.expand(database_ssl_ca_cert_path)
    ],
    show_sensitive_data_on_connection_error: true,
    pool_size: 10,
    parameters: [
      options: database_cluster_name
    ],
    migration_lock: false # cockroach does not support migration locking

  if config_env() == :prod do
    # database_url =
    #   System.get_env("DATABASE_URL") ||
    #     raise """
    #     environment variable DATABASE_URL is missing.
    #     For example: ecto://USER:PASS@HOST/DATABASE
    #     """

    maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

    config :coffee_chat, CoffeeChat.Repo,
      # ssl: true,
      # url: database_url,
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
      socket_options: maybe_ipv6

    # The secret key base is used to sign/encrypt cookies and other secrets.
    # A default value is used in config/dev.exs and config/test.exs but you
    # want to use a different value for prod and you most likely don't want
    # to check this value into version control, so we use an environment
    # variable instead.
    secret_key_base =
      System.get_env("SECRET_KEY_BASE") ||
        raise """
        environment variable SECRET_KEY_BASE is missing.
        You can generate one by calling: mix phx.gen.secret
        """

    host = System.get_env("PHX_HOST") || "example.com"
    port = String.to_integer(System.get_env("PORT") || "4000")

    config :coffee_chat, CoffeeChatWeb.Endpoint,
      url: [host: host, port: 443],
      http: [
        # Enable IPv6 and bind on all interfaces.
        # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
        # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
        # for details about using IPv6 vs IPv4 and loopback vs public addresses.
        ip: {0, 0, 0, 0, 0, 0, 0, 0},
        port: port
      ],
      secret_key_base: secret_key_base
end
