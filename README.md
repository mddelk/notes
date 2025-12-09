# notes

A simple note-taking web app.

> [!NOTE]
>
> This is a _hobby_ project, don't expect stability, documentation, security fixes, etc.

## Tech stack

Rails 8 with Hotwire + Stimulus, Tailwind, Importmaps, and SQLite.

## Getting started

```sh
git clone https://github.com/jethrodaniel/notes && cd notes && bin/setup
```

Then visit http://localhost:3000 in your browser.

You can sign in with the default credentials (see `db/seeds.rb` for details):

```
email: admin@notes.localhost
password: password
```

## Testing

```sh
bin/ci
```

You may also need to install dependencies for system tests:

```sh
snap install chromium # e.g, on ubuntu 24.04
```

And `prettier` (linting):

```sh
sudo apt install -y npm
npm install
```

## Deployment

The app is setup to deploy to a single server using Kamal and [Bitwarden Secret Manager](https://kamal-deploy.org/docs/commands/secrets/#bitwarden-secrets-manager).

## Container registry

Kamal currently requires a container registry.

Most likely, you'll want your images to be private - an easy way set this up is to create a private Gitlab repository, and use the free container registry service that provides.

### Rails credentials

Before deploying, you need to fill in the required credentials:

```console
bin/rails credentials:edit -e production
```

```yaml
secret_key_base: your-secret-key-base

kamal:
  service: notes-production
  image: username/notes
  proxy_host: your.deploy.url
  registry_server: registry.example.com
  registry_username: username
  registry_password: password
  retain_containers: 2
  server: 192.123.456.789
  ssh_user: username
  volume_storage: notes_production_storage:/rails/storage

smtp:
  user_name: username
  password: password
  address: your.smtp.address
  host: your.smtp.host
  port: 123
  authentication: TODO
  host: your.deploylurl
  from: user@your.deploy.url
```

Setting up staging is similar, just change the hosts/volumes/etc to the `staging` versions.

```console
bin/rails credentials:edit -e staging
```

```yaml
kamal:
  service: notes-staging
  proxy_host: staging.your.deploy.url
  volume_storage: notes_staging_storage:/rails/storage
  # ...
```

### Setup bitwarden

Create a bitwarden account.

Setup a secrets manager project for each environment and provide `RAILS_MASTER_KEY`.

Projects should be named `notes-production`, `notes-staging`, etc (match `RAILS_ENV`).

Download and setup the secrets manager: https://bitwarden.com/help/secrets-manager-cli/

Then add your bitwarden info to `.env`:

```sh
cp -v .env.example .env
```
```sh
# .env
export BWS_ACCESS_TOKEN="your token goes here"
export BWS_SERVER_URL=https://vault.bitwarden.com
```

Sanity check if it works like so:

```sh
RAILS_ENV=production bin/dotenv bin/kamal secrets print
```

**NOTE**: the above setup requires every instance of `kamal` be called with `RAILS_ENV` and `bin/dotenv bin/kamal`.

#### Server setup

Vendor our own `kamal-proxy`:

```sh
bin/dotenv bin/update_kamal_proxy
```

Tell our server to use that image:

```sh
bin/tell_kamal_to_use_our_proxy_image
```

#### Deploy

```sh
RAILS_ENV=staging bin/dotenv bin/kamal deploy
RAILS_ENV=production bin/dotenv bin/kamal deploy
```

One time setup needed afterwards:

```sh
# create databases, seed staging
RAILS_ENV=staging bin/dotenv bin/kamal app exec 'bin/rails db:setup'
RAILS_ENV=production bin/dotenv bin/kamal app exec 'bin/rails db:setup'

# production: create your user (see db/seeds.rb)
# staging: update your weak db/seed user's password
#
RAILS_ENV=staging bin/dotenv bin/kamal console
RAILS_ENV=production bin/dotenv bin/kamal console
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

Non-english translations were performed (crudely) using AI translate.

Spanish `datetime.distance_in_words` translations are from [svenfuchs/rails-i18n](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/rails/locale/es.yml#L63C1-L101C31) ([MIT](https://github.com/svenfuchs/rails-i18n/blob/16ed6762fb666e91251e350572fadbea68c68359/MIT-LICENSE.txt)).

## License

Notes is released under the [GNU Affero General Public License Version 3 (AGPLv3) or any later version](https://spdx.org/licenses/AGPL-3.0-or-later.html).

Copyright 2025 Mark Delk. All rights reserved.

## Contributing

While the code is released under the AGPL, I'd still like to be able to release it under something like the [MIT license](https://spdx.org/licenses/MIT.html) eventually.

To that end, contributions aren't accepted (yet).
