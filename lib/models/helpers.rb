module RoutesModule
  module Helpers
    class PointNotFoundError < StandardError
    end

    def routes_matrix
      routes = []
      # populating routes like a matrix for graph
      Route.all.each { |r| routes.append [r.origin_point,
                                          r.destination_point,
                                          r.distance] }
      routes
    end

    def validate_point!(point)
      if not Route.points.include?(point)
        raise PointNotFoundError, "#{point} point not found"
      end
      true
    end

    def calculate_shortest_path(origin_point, destination_point)
      begin
        validate_point!(origin_point)
        validate_point!(destination_point)

        require_relative './../dijkstra/dijkstra'
        g = Graph.new(routes_matrix)
        path, dst = g.shortest_path(origin_point, destination_point)
      rescue PointNotFoundError => exception
        raise exception
      end
    end

    def calculate_cost(distance, autonomy, fuel_price)
      distance * fuel_price / autonomy
    end
  end
end