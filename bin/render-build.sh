set -o errexit
bundle install --deployment
bundle exec db:prepare
bundle exec db:seed

