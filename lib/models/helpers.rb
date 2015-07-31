module WalmartChallengeAPIModule
  module Helpers
    def routes_matrix
      routes = []
      # populating routes like a matrix for graph
      Route.all.each { |r| routes.append [r.origin_point,
                                          r.destination_point,
                                          r.distance] }
      routes
    end

    def calculate_shortest_path(start, stop)
      require_relative './../dijkstra/dijkstra'
      g = Graph.new(routes_matrix)
      path, dst = g.shortest_path(start, stop)
    end

    def calculate_cost(distance, autonomy, fuel_price)
      distance * fuel_price / autonomy
    end
  end
end