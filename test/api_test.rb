require './test/test_helper'
require 'rack/test'
require 'sinatra/base'
require 'api'

class APITest < MiniTest::Test
  include Rack::Test::Methods

  def app
    WalmartChallengeAPI
  end

  def test_show_all_routes
    route = Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
    get '/routes'
    expected = "[{\"id\":#{route.id},\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}]"
    assert_equal expected, last_response.body
  end

  def test_calculate_cost
    seed_file = File.join('db/seeds.rb')
    load(seed_file) if File.exists?(seed_file)

    data = '{"origin_point": "A", "destination_point": "D", "autonomy": 10, "fuel_price": 2.5}'
    post '/routes/calculate-cost', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"cost\":6.25,\"route\":\"A B D\"}"
    assert_equal expected, last_response.body
  end
end