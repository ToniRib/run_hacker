web: bundle exec unicorn rails server -p $PORT -c config/initializers/sidekiq.yml
worker: bundle exec sidekiq -e production -c 5
