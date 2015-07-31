require_relative './dijkstra/dijkstra'

class WalmartChallengeAPI < Sinatra::Base
  get '/' do
    'Walmart Challenge API :)'
  end

  get '/routes' do
    Route.all.to_json
  end

  post '/routes/calculate-cost' do
    routes = []

    # populating routes like a matrix for graph
    Route.all.each { |r| routes.append [r.origin_point.to_sym,
                                        r.destination_point.to_sym,
                                        r.distance] }
    # getting params
    origin_point = params[:origin_point].to_sym
    destination_point = params[:destination_point].to_sym
    autonomy = params[:autonomy].to_f
    fuel_price = params[:fuel_price].to_f

    # calculating
    g = Graph.new(routes)
    path, dst = g.shortest_path(origin_point, destination_point)
    route_path = path.join(" ")
    cost = dst.to_f * fuel_price / autonomy

    JSON.dump({ :cost => cost, :route => route_path})
  end
end