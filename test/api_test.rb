require './test/test_helper'
require 'rack/test'
require 'sinatra/base'
require 'api'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class APITest < MiniTest::Test
  include Rack::Test::Methods
  include WithRollback

  def app
    WalmartChallengeAPI
  end

  def test_hello_world
    get '/'
    assert_equal 'Walmart Challenge API :)', last_response.body
  end

  def test_show_all_routes
    temporarily do
      route = Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
      get '/routes'
      expected = "[{\"id\":#{route.id},\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}]"
      assert_equal expected, last_response.body
    end
  end

  def test_calculate_minimum_cost_route
    data = '{"origin_point": "A", "destination_point": "D", "autonomy": 10, "fuel_price": 2.5}'
    post '/routes/calculate-cost', JSON.parse(data), { "content_type" => "application/json"}
    expected = "{\"cost\":6.25,\"route\":\"A B D\"}"
    assert_equal expected, last_response.body
  end
end