set -o errexit
bundle install
bundle exec db:prepare
bundle exec db:migrate RAILS_ENV=test
