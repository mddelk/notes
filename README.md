# notes

A simple note-taking web app.

> [!NOTE]
>
> This is a _hobby_ project, don't expect stability, documentation, security fixes, etc.

## Setup

1. Install dependencies: `ruby`, `yarn`, and `sqlite3`
2. Clone this repo: `git clone https://github.com/jethrodaniel/notes && cd notes`
3. Run a one-time setup script: `bin/setup`
4. Run the application locally: `bin/dev`

Visit http://localhost:3000 in your browser, and sign in with these credentials:

```
email: admin@app.localhost
password: password
```

## Testing

1. Install test dependencies: `yarn` and `chromium`
2. Run the tests: `bin/ci`

## Deploy

1. Setup your secrets manager:

Setup [bitwarden secrets manager](https://bitwarden.com/help/secrets-manager-cli):

- Create 2 projects, `notes-production` and `notes-staging`, and add a `RAILS_MASTER_KEY` to each
- Install and configure `bws` - `cp .env.example .env`, add the following, then `eval $(cat .env)`:

```
export BWS_ACCESS_TOKEN='REDACTED'
export BWS_SERVER_URL=https://vault.your-bitwarden.com
```

2. Configure your deploy

```
bin/rails credentials:edit -e production
bin/rails credentials:edit -e staging
```

```yaml
kamal:
  proxy_host: your.deploy.url
  server: 192.123.456.789
  ssh_user: username
  ssh_port: 22

smtp:
  user_name: username
  password: password
  address: your.smtp.address
  host: your.smtp.host
  port: 123
  authentication: TODO
  host: your.deploy.url
  from: user@your.deploy.url
```

3. Deploy

```
bin/kamal deploy -d staging
bin/kamal deploy -d production
```

## Logo

To generate the `favicon.ico`:

```sh
inkscape app/assets/images/icon.svg --export-width=256 --export-filename=tmp.png
convert tmp.png -define icon:auto-resize=256,64,48,32,16 app/assets/images/favicon.ico
rm tmp.png
```

## I18n

Users can change their language in-app to either English or Spanish.

Non-logged in pages (e.g, sign-in) aren't translated yet.

Spanish `datetime.distance_in_words` translations are from [svenfuchs/rails-i18n](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/rails/locale/es.yml#L63C1-L101C31) ([MIT](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/MIT-LICENSE.txt)).

## License

Notes is released under the [GNU Affero General Public License Version 3 (AGPLv3) or any later version](https://spdx.org/licenses/AGPL-3.0-or-later.html).

Copyright 2025 Mark Delk. All rights reserved.

## Contributing

While the code is released under the AGPL, I'd still like to be able to release it under something like the [MIT license](https://spdx.org/licenses/MIT.html) eventually.

To that end, contributions aren't accepted (yet).
