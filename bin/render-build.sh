set -o errexit
bundle install
bundle exec DISABLE_DATABASE_ENVIRONMENT_CHECK=1
bundle exec rake db:reset
bundle exec rake db:migrate
