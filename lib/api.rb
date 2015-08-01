require_relative './models/helpers'

class RoutesAPIApp < Sinatra::Base
  include RoutesModule::Helpers

  get '/' do
      'Routes API :)'
  end

  get '/routes' do
    Route.all.to_json
  end

  post '/routes/calculate-cost' do
    origin_point = params[:origin_point]
    destination_point = params[:destination_point]
    autonomy = params[:autonomy].to_f
    fuel_price = params[:fuel_price].to_f

    path, distance = calculate_shortest_path(origin_point, destination_point)
    cost = calculate_cost distance.to_f, autonomy, fuel_price

    JSON.dump({ :cost => cost, :route => path.join(" ")})
  end
end