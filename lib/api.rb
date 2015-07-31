class WalmartChallengeAPI < Sinatra::Base
  def routes_matrix
    routes = []
    # populating routes like a matrix for graph
    Route.all.each { |r| routes.append [r.origin_point,
                                        r.destination_point,
                                        r.distance] }
    routes
  end

  def calculate_shortest_path(start, stop)
    require_relative './dijkstra/dijkstra'
    g = Graph.new(routes_matrix)
    path, dst = g.shortest_path(start, stop)
  end

  def calculate_cost(distance, autonomy, fuel_price)
    distance * fuel_price / autonomy
  end
  get '/' do
    'Walmart Challenge API :)'
  end

  get '/routes' do
    Route.all.to_json
  end

  post '/routes/calculate-cost' do
    routes = routes_matrix
    origin_point = params[:origin_point]
    destination_point = params[:destination_point]
    autonomy = params[:autonomy].to_f
    fuel_price = params[:fuel_price].to_f
    path, distance = calculate_shortest_path(origin_point, destination_point)
    route_path = path.join(" ")
    cost = calculate_cost distance.to_f, autonomy, fuel_price

    JSON.dump({ :cost => cost, :route => route_path})
  end
end