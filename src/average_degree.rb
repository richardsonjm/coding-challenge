require_relative '../config/environment.rb'

class AverageDegree
  def initialize(source, destination, time)
    @source = File.read(source)
    @destination = File.open(destination, 'w')
    @hashtag_sets = []
    @hashtags = []
    @timestamps = []
    @time = time
  end

  def avg_degree(timestamp, hashtags)
    @timestamps << timestamp
    if timestamp < (@timestamps.first + @time)
      @hashtag_sets << hashtags
      @hashtags.concat(hashtags)
      record_avg_degree(@hashtags.count, @hashtag_sets.count)
    else
      @timestamps.shift
      delete_list = @hashtag_sets.shift
      delete_list.each do |del|
        @hashtags.delete_at(@hashtags.index(del))
      end
      avg_degree(timestamp, hashtags)
    end
  end

  def record_avg_degree(edges, nodes)
    @destination.write((edges/nodes).to_s + "\n")
  end

  def run
    @source.each_line do |line|
      next if line == "\n"
      next if line.include? "tweets contained unicode"
      date_string = line.match(/(?<=timestamp: ).+/).to_s
      timestamp = DateTime.strptime(date_string, "%a %b %d %k:%M:%S %z %Y") if date_string =~ /\d/
      hashtags = line.scan(/#([A-Za-z0-9]+)/).flatten.collect {|hashtag| hashtag.downcase}
      avg_degree(timestamp, hashtags) if hashtags.count > 1
    end
  end
end
