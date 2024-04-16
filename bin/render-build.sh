set -o errexit
bundle install
RAILS_ENV=production rake db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1 

bundle exec rake db:migrate
