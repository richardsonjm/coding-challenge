require_relative '../config/environment.rb'

HASHTAGS_SETS = []
HASHTAGS = []
TIMESTAMPS = []

File.read('./tweet_output/ft1.txt').each_line do |line|
  next if line == "\n"
  next if line.include? "tweets contained unicode"
  timestamp = DateTime.strptime(line.match(/(?<=timestamp: ).+/).to_s, "%a %b %d %k:%M:%S %z %Y")
  hashtags = line.scan(/#([A-Za-z0-9]+)/).flatten.collect {|hashtag| hashtag.downcase}
  p hashtags if hashtags.any?
  if (hashtags.count > 1) && (timestamp < (TIMESTAMPS.first + 60))
    HASHTAGS_SETS << hashtags
    HASHTAGS.concat(hashtags)
    TIMESTAMPS << timestamp
  else
    TIMESTAMPS.shift
    delete_list = HASHTAGS_SETS.shift
    delete_list.each do |del|
      HASHTAGS.delete_at(HASHTAGS.index(del))
    end
  end
end




# def dup_hash(ary)
#   ary.inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select {
#     |k,v| v > 1 }.inject({}) { |r, e| r[e.first] = e.last; r }
# end

# dingo = HASHTAGS.inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select {
#     |k,v| v > 1 }.inject({}) { |r, e| r[e.first] = e.last; r }

# p dingo

# ADJ = { A => [B,C], B => [A,D], C => [A,D], D => [B,C], E => [D] }
  # edge_list[hashtags[0]] = hashtags[1..-1] if (hashtags && hashtags.count > 1)

    # while i < hashtags.count && hashtags[i +1] != nil
    #   edge_list[hashtags[i]] = hashtags[i+1]
    #   i+=1
    # end
# class Node
#   attr_accessor :neighbors, :datum

#   def initialize(datum, *neighbors)
#     @neighbors = neighbors
#     @datum = datum
#   end

#    def inspect
#     "#{datum} -> [#{neighbors.map(&:datum).join(", ")}]"
#   end
# end

# #we get all the cool methods from Array and Enumerable!
# class Graph < Array; end


# node_a = Node.new(:hello)
# node_b = Node.new(:world, node_a)
# node_c = Node.new(:im_out_of_strings, node_b)
# node_a.neighbors << node_c

# a_graph = Graph.new([
#   node_a,
#   node_b,
#   node_c
# ])

# p a_graph

