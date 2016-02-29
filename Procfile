web: bundle exec unicorn rails server -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -e production -c 5
