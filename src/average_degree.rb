


File.read(tweets_clean).each_line do |line|
  hashtags = line.scan(/#([A-Za-z0-9]+)/).flatten
  p hashtags if hashtags.any?
  ug = RGL::DirectedAdjacencyGraph[hashtags.join(', ')]
  # ug = RGL::DirectedAdjacencyGraph[1,2 ,2,3 ,2,4, 4,5, 6,4, 1,6]
  p ug
end
