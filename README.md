# coffee-chat
chat server implemented in elixir

## Design overview

## Backend Database
Using CockroachDB's serverless database as the backend for this project. It's pretty easy to setup, and it takes a lot of the burden off of scalability which is a big consideration for build chat apps.

There are some other cool features of CockroachDB that make it nice for this project:
1. Hash sharded indices (low-latency retrieval for ranged data - e.g. retrieving messages)
2. Highly available, if one of our nodes goes down the chat app will continue to function as expected (Cockroach has a minimum of 3 replicas)
3. Cockroach serverless takes the burden off of having to think about how the app scales - and there's a pretty generous free tier 

### Setting up the database
If you want to set this up using Cockroach's serverless free-tier, head on over to https://cockroachlabs.cloud and create an account.

Once you create an account, you can create a free-tier cluster. You can call this whatever you'd like.

From here, you'll need to navigate over to the cluster and click on the connect button. Follow the prompts for downloading the CA certificate and grab the connection string. 

Now you'll need to parse the connection string and export the following environment variables:
```shell
export COCKROACH_USERNAME="$insert_cockroach_username_here" \
    COCKROACH_PASSWORD="$insert_cockroach_password_here" \
    COCKROACH_HOSTNAME="$insert_cockroach_hostname_here" \
    COCKROACH_DATABASE="$insert_cockroach_database_here" \
    COCKROACH_PORT="$insert_cockroach_port_here" \
    COCKROACH_CA_CERT_PATH="$insert_cockroach_ca_cert_path_here" \
    COCKROACH_CLUSTER="$insert_cockroach_cluster_options_here"
```
_If you need some help figuring out what these values should be, take a look at `config/runtime.exs`_

If you don't want to sign up for the hosted serverless option, you can edit the Docker Compose file in this repo to set up a local cluster - here's a link for some doccumentation from Cockroach: https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac.html 

_(Note: using a Docker cluster is insecure and *should not* be deployed. If you need to deploy, reconsider the hosted option, or you can check out the manual deployment option for your preferred cloud provider/on-prem https://www.cockroachlabs.com/docs/stable/manual-deployment.html)_


## TODOs
- [x] Write migration files
- [ ] Write boilerplate queries
  - [ ] tighten up changesets for users
- [ ] Write tests for backend
- [ ] Start working on front end / liveviews (use Phoenix PubSub for liveview updates)
- [ ] Shift focus to work on end to end encryption

### Phoenix

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
