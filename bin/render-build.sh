set -o errexit
bundle install
bundle exec rake db:seed
bundle exec rake db:migrate
