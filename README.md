# notes

A simple note-taking web app.

> [!NOTE]
>
> This is a _hobby_ project, don't expect stability, documentation, security fixes, etc.

## local dev

Just normal Rails setup:

- install `ruby` and `sqlite3`, and for tests, `yarn` and `chromium`
- `git clone https://github.com/jethrodaniel/notes && cd notes`
- `bin/setup`
- `bin/dev`
- visit http://localhost:3000
- sign in with `email: admin@app.localhost`, `password: password`
- run tests with `bin/ci`

## deploy

### secrets manager setup

We're using [bitwarden secrets manager](https://kamal-deploy.org/docs/commands/secrets/#:~:text=Bitwarden%20Secrets%20Manager).

- create 2 projects, `notes-production` and `notes-staging`, and add `RAILS_MASTER_KEY` to each
- install [`bws`](https://bitwarden.com/help/secrets-manager-cli)
- `cp .env.example .env`, add your bitwarden configuration
- `eval $(cat .env)`

sanity check with `bin/bws-get-project-id notes-production`.

### credentials

```
bin/rails credentials:edit -e production
bin/rails credentials:edit -e staging
```

Add the following:

```yaml
deploy:
  local_backups_directory: /some/local/path
  remote_backups_directory: /some/remote/path
  digital_ocean_token: XXX
  monitoring_email: your@monitoring.email

kamal:
  proxy_host: your.deploy.url
  server: 192.123.456.789
  ssh_user: username
  ssh_port: 22
```

### kamal

Deploy with [kamal](https://kamal-deploy.org/):

```
bin/kamal deploy -d staging
bin/kamal deploy -d production
```

### backups

Download a local backup:

```
bin/rails runner script/backup.rb -e staging
bin/rails runner script/backup.rb -e production
```

## license

```
SPDX-FileCopyrightText: Copyright (c) 2025 Mark Delk
SPDX-License-Identifier: AGPL-3.0-or-later
```

Also:

- spanish `datetime.distance_in_words` translations from [svenfuchs/rails-i18n](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/rails/locale/es.yml#L63C1-L101C31) ([MIT](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/MIT-LICENSE.txt)).

## contributing

You don't - contributions aren't accepted.
