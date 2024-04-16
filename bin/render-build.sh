set -o errexit
bundle install
bundle exec db:prepare
bundle exec rake db:migrate
bundle exec db:seed

