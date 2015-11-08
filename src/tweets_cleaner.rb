#!/usr/bin/env ruby
require_relative '../config/environment.rb'

class TweetsCleaner
  def initialize(source, destiniation)
    @unicode_count = 0
    @raw = File.read(source)
    @cleaned = File.open(destiniation, 'w')
  end

  def convert_line_to_json(line)
    JSON.parse(line)
  end

  def remove_unicode(text)
    text.gsub(/[^\x00-\x7F]/, '')
  end

  def remove_escape_characters(text)
    text.dump.
      gsub(/\\\//, '/').
      gsub(/\\\\/, "\\").
      gsub(/\/'/, "'").
      gsub(/\\\"/, "\"").
      gsub(/(\\[abfmntr])/, ' ').
      gsub("  ", " ")
  end

  def remove_quotes(text)
    text.gsub(/^"|"$/, '')
  end

  def clean_text(text)
    return unless text
    @unicode_count += 1 unless text.ascii_only?
    text = remove_unicode(text)
    text = remove_escape_characters(text)
    text = remove_quotes(text)
  end

  def write_clean_line(text, timestamp)
    @cleaned.write("#{text} (timestamp: #{timestamp})\n")
  end

  def write_unicode_count
    @cleaned.write("\n")
    @cleaned.write("#{@unicode_count.to_s} tweets contained unicode.")
  end

  def run
    @raw.each_line do |line|
      line_json = convert_line_to_json(line)
      text = clean_text(line_json["text"])
      timestamp = line_json["created_at"]
      write_clean_line(text, timestamp)
    end
    write_unicode_count
    @cleaned.close
  end
end

TweetsCleaner.new('./tweet_input/tweets.txt', './tweet_output/ft1.txt').run
