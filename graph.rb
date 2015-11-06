class Node
  attr_accessor :neighbors, :datum

  def initialize(datum, *neighbors)
    @neighbors = neighbors
    @datum = datum
  end

   def inspect
    "#{datum} -> [#{neighbors.map(&:datum).join(", ")}]"
  end
end

#we get all the cool methods from Array and Enumerable!
class Graph < Array; end


node_a = Node.new(:hello)
node_b = Node.new(:world, node_a)
node_c = Node.new(:im_out_of_strings, node_b)
node_a.neighbors << node_c

a_graph = Graph.new([
  node_a,
  node_b,
  node_c
])

p a_graph
