source "https://rubygems.org"

ruby file: ".tool-versions"

gem "rails", "~> 8.1.0"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[windows jruby]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "image_processing", "~> 1.2"

gem "sqlite_extensions-uuid"
gem "pagy", "~> 43.0"
gem "faker"

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "rubocop-lazy-config",
    github: "jethrodaniel/rubocop-lazy-config",
    require: false
end

group :development do
  gem "web-console"
  gem "i18n-tasks", require: false
end

group :test do
  gem "capybara"
  gem "cuprite"
end
