require_relative './config/environment.rb'

TweetsCleaner.new('./tweet_input/tweets.txt', './tweet_output/ft1.txt').run
AverageDegree.new('./tweet_output/ft1.txt', './tweet_output/ft2.txt', 60).run
