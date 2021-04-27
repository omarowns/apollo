# README

## Ruby version
`2.7.2`

## Rails version
`6.1.3.1`

## System dependencies
- `redis`

## Configuration

Go to https://developer.spotify.com/dashboard and create a new app. Copy the client ID and client secret

Set up your credentials by first deleting `config/creadentials.yml.enc`

Create again with `EDITOR=vim bin/rails credentials:edit`

Should look like this:

```yml
secret_key_base: <secret key base>
spotify:
  client_id: <client_id>
  client_secret: <client_secret>
```

## Database creation
`rails db:create`

## Database initialization
`rails db:migrate`

## How to run the test suite

No tests for the moment ( ͡° ʖ̯ ͡°)

## Services (job queues, cache servers, search engines, etc.)

ActiveJob backend is `sidekiq`, so run sidekiq with `bin/sidekiq`

Run `rake spotify:fetch_players` to fetch the initial User's players.
