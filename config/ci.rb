# Run using bin/ci

CI.run "bin/ci", "Make it so" do
  step "Setup", "bin/setup --skip-server"

  step "Style: Ruby", "bin/rubocop"
  step "Style: Javascript", "yarn run lint"
  step "Style: Translations", "bundle exec i18n-tasks health"
  step "Style: ERB (linter)", "yarn run herb:lint"
  step "Style: ERB (formatter)", "yarn run herb:format:check"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Importmap vulnerability audit", "bin/importmap audit"
  step "Security: Brakeman code analysis",
    "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: Rails", "BROWSER=rack-test bin/rails test:all"
  step "Tests: System", "PARALLEL_WORKERS=4 bin/rails test:system"
  step "Tests: Seeds", "env RAILS_ENV=test bin/rails db:seed:replant"
end
