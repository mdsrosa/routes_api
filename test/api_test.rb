require './test/test_helper'
require 'rack/test'
require 'sinatra/base'
require 'api'

class APITest < MiniTest::Test
  include Rack::Test::Methods
  include WithRollback

  def app
    WalmartChallengeAPI
  end

  def test_show_all_routes
    temporarily do
      route = Route.create(:origin_point => 'A', :destination_point => 'D', :distance => 20)
      get '/'
      expected = "[{\"id\":#{route.id},\"origin_point\":\"A\",\"destination_point\":\"D\",\"distance\":20}]"
      assert_equal expected, last_response.body
    end
  end
end