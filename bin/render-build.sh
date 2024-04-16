set -o errexit
bundle install
bundle exec db:prepare
bin/rails db:migrate RAILS_ENV=test
