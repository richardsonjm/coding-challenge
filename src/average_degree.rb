require_relative '../config/environment.rb'

class AverageDegree
  def initialize(source, destination, time)
    @source = File.read(source)
    @destination = File.open(destination, 'w')
    @hashtag_sets = []
    @hashtags = []
    @timestamps = []
    @time = time
    @last_avg = 0.to_s
    @timestamp = nil
  end

  def avg_degree(timestamp, hashtags)
    @timestamps << timestamp
    if (hashtags.count > 1) && (timestamp < (@timestamps.first + @time))
      @hashtag_sets << hashtags
      @hashtags.concat(hashtags)
      @last_avg = (@hashtags.count/@hashtag_sets.count.to_f).round(2).to_s
      @destination.write(@last_avg + "\n")
    elsif timestamp < (@timestamps.first + @time)
      @destination.write(@last_avg + "\n")
    else
      @timestamps.shift
      delete_list = @hashtag_sets.shift
      delete_list.each do |del|
        @hashtags.delete_at(@hashtags.index(del))
      end
      @destination.write(@last_avg + "\n")
      avg_degree(timestamp, hashtags)
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
