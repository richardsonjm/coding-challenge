require 'json'

tweets_raw = File.read('./tweet_input/tweets.txt')
tweets_clean = File.open('./tweet_output/ft1.txt', 'w')

unicode_counter = 0
tweets_raw.each_line do |line|
  line_json = JSON.parse(line)
  text = line_json["text"]
  unicode_counter += 1 unless text.ascii_only?
  clean_text = text.encode(Encoding.find('ASCII'), invalid: :replace, undef: :replace, replace: '').dump.gsub(/(\\[abfmntr"'\/]|\"|^"|"$)/, '').gsub(/\\\//, '')
  timestamp = line_json["created_at"]
  tweets_clean.write("#{clean_text} (timestamp: #{timestamp})\n")
end

tweets_clean.write("\n")
tweets_clean.write("#{unicode_counter.to_s} tweets contained unicode.")
tweets_clean.close
