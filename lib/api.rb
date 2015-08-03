require_relative './models/helpers'
require 'sinatra/param'

class RoutesAPIApp < Sinatra::Base
  include RoutesModule::Helpers
  helpers Sinatra::Param

  PARAMS = {
    :origin_point => {:type => String, :required => true},
    :destination_point => {:type => String, :required => true},
    :autonomy => {:type => String, :required => true},
    :fuel_price => {:type => String, :required => true}
  }

  set :raise_sinatra_param_exceptions, true
  set :show_exceptions, false
  set :raise_errors, true

  error Sinatra::Param::InvalidParameterError do
    {error: "#{env['sinatra.error'].param} #{env['sinatra.error'].message.downcase}"}.to_json
  end

  get '/' do
      'Routes API :)'
  end

  get '/routes' do
    Route.all.to_json
  end

  post '/routes' do
    route = Route.new(params)
    if route.valid?
      route.save
      route.to_json
    else
      errors = []
      route.errors.messages.each do |(field, messages)|
        messages = messages.join(", ")
        errors.append "#{field}: #{messages}"
      end
      { :errors => errors }.to_json
    end
  end

  post '/routes/calculate-cost' do
    PARAMS.keys.each do |key, value|
      param "#{key}", PARAMS[key][:type], required: PARAMS[key][:required]
    end

    origin_point = params[:origin_point]
    destination_point = params[:destination_point]
    autonomy = params[:autonomy].to_f
    fuel_price = params[:fuel_price].to_f

    begin
      path, distance = calculate_shortest_path(origin_point, destination_point)
      cost = calculate_cost distance.to_f, autonomy, fuel_price
      JSON.dump({ :cost => cost, :route => path.join(" ")})
    rescue PointNotFoundError => exception
      JSON.dump({ :error => exception.message })
    end
  end
end