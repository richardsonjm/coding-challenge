require_relative './config/environment.rb'

TweetCleaner.new('./tweet_input/tweets.txt', './tweet_output/ft1.txt').run
