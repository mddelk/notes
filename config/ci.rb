# Run using bin/ci

CI.run "bin/ci", "Make it so" do
  step "Setup", "bin/setup --skip-server"

  step "Style: Ruby", "bin/rubocop"
  step "Style: Javascript", "yarn run lint"
  step "Style: Translations", "bundle exec i18n-tasks health"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Importmap vulnerability audit", "bin/importmap audit"
  step "Security: Brakeman code analysis",
    "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: Rails", "BROWSER=rack-test bin/rails test:all"
  step "Tests: System", "bin/rails test:system"
end
