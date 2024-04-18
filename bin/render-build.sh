set -o errexit
bundle install
# # In case you want to reset the database
bundle exec rake db:migrate
RAILS_ENV=production rake db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1 
bundle exec rake db:migrate
