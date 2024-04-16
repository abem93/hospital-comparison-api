set -o errexit
bundle install
bundle exec rake db:reset
bundle exec rake db:migrate
