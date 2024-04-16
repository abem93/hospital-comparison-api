set -o errexit
bundle install --deployment
bundle exec db:prepare
bundle exec db:migrate RAILS_ENV=test
