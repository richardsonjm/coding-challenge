#!/usr/bin/env ruby
require_relative '../config/environment.rb'

class AverageDegree
  def initialize(source, destination, time)
    @source = File.read(source)
    @destination = File.open(destination, 'w')
    @tweet_hashtags = []
    @edges = []
    @nodes = []
    @timestamps = []
    @time = time
    @current_avg = 0.to_s
    @timestamp = nil
  end

  def avg_degree(timestamp, hashtags)
    @timestamps << timestamp
    if (hashtags.count > 1) && (timestamp < (@timestamps.first + @time))
      @tweet_hashtags << hashtags
      add_hashtags_to_nodes_and_edges(hashtags)
      @current_avg = (@edges.count/@nodes.count.to_f).round(2).to_s
      @destination.write(@current_avg + "\n")
    elsif timestamp < (@timestamps.first + @time)
      @destination.write(@current_avg + "\n")
    else
      @timestamps.shift
      @tweet_hashtags.shift
      @destination.write(@current_avg + "\n")
      reset_nodes_and_edges
      avg_degree(timestamp, hashtags)
    end
  end

  def reset_nodes_and_edges
    @edges = []
    @node = []
    @tweet_hashtags.each do |hashtags_array|
      add_hashtags_to_nodes_and_edges(hashtags_array)
    end
  end

  def add_hashtags_to_nodes_and_edges(hashtags)
    hashtags.each_with_index do |hashtag, index|
      return unless hashtags[index + 1]
      edge = [hashtags[index], hashtags[index + 1]]
      if !@edges.include?(edge) && !@edges.include?(edge.reverse)
        @edges.concat(edge)
      end
      @nodes << hashtag unless @nodes.include? hashtag
    end
  end

  def run
    @source.each_line do |line|
      next if line == "\n"
      next if line.include? "tweets contained unicode"
      date_string = line.match(/(?<=timestamp: ).+/).to_s
      @timestamp = DateTime.strptime(date_string, "%a %b %d %k:%M:%S %z %Y") if date_string =~ /\d/
      hashtags = line.scan(/#([A-Za-z0-9]+)/).flatten.collect {|hashtag| hashtag.downcase}
      avg_degree(@timestamp, hashtags)
    end
  end
end

AverageDegree.new('./tweet_output/ft1.txt', './tweet_output/ft2.txt', 60).run
