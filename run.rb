require_relative './config/environment.rb'

TweetCleaner.new('./tweet_input/tweets.txt', './tweet_output/ft1.txt').run
AverageDegree.new('./tweet_output/ft1.txt', 60).run
