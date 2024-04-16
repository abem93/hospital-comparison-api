set -o errexit
bundle install
bundle exec db:migrate RAILS_ENV=production
bundle exec db:prepare
bundle exec db:seed

