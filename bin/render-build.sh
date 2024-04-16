set -o errexit
bundle install
bundle exec rake db:migrate
bundle exec db:seed
bundle exec rake db:migrate 