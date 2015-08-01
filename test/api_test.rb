require './test/test_helper'
require 'rack/test'
require 'sinatra/base'
require 'api'

class APITest < MiniTest::Test
  include Rack::Test::Methods

  def app
    RoutesAPIApp
  end

  def test_show_all_routes
    route = Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
    get '/routes'
    expected = "[{\"id\":#{route.id},\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}]"
    assert_equal expected, last_response.body
  end

  def test_create_route
    data = '{"origin_point":"A", "destination_point": "D", "distance": 20}'
    post '/routes', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"id\":1,\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}"
    assert_equal expected, last_response.body
  end

  def test_create_route_uniqueness
    data = '{"origin_point":"A", "destination_point": "D", "distance": 20}'
    post '/routes', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"id\":1,\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}"

    assert_equal expected, last_response.body

    post '/routes', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"errors\":[\"origin_point: has already been taken\"]}"

    assert_equal expected, last_response.body
  end

  def test_create_route_invalid_data
    data = '{"origin_point": "A", "destination_point": "D", "distance": "A"}'
    post '/routes', JSON.parse(data), 'Content-Type' => 'application/json'
    expected = "{\"errors\":[\"distance: is not a number\"]}"
    assert_equal expected, last_response.body
  end

  def test_create_route_missing_field
    data = '{"origin_point": "A", "destination_point": "D"}'
    post '/routes', JSON.parse(data), 'Content-Type' => 'application/json'
    expected = "{\"errors\":[\"distance: can't be blank\"]}"
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

  def test_calculate_cost_missing_fields
    data = '{"destination_point": "D", "autonomy": 10, "fuel_price": 2.5}'
    post '/routes/calculate-cost', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"error\":\"origin_point parameter is required\"}"
    assert_equal expected, last_response.body
  end

  def test_calculate_cost_with_nonexistent_point
    seed_file = File.join('db/seeds.rb')
    load(seed_file) if File.exists?(seed_file)

    data = '{"origin_point": "A", "destination_point": "X", "autonomy": 10, "fuel_price": 2.5}'
    post '/routes/calculate-cost', JSON.parse(data), { 'Content-Type' => 'application/json' }
    expected = "{\"error\":\"X point not found\"}"
    assert_equal expected, last_response.body
  end
end